class User < ApplicationRecord
  enum access_level: { student: 0, staff: 1, admin: 2 }

  before_destroy :cleanup

  validates :email, uniqueness: true
  has_many :passwords
  LDAP_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/ldap.yml")).result)[Rails.env]

  extend FriendlyId
  friendly_id :username, use: :slugged

  def cleanup
    Password.where(:user_id => self.id).destroy_all
  end


  def self.ldap_connection(username = nil, password = nil)
    # ldap = Net::LDAP.new
    # ldap.host = LDAP_CONFIG["host"]
    # ldap.port = LDAP_CONFIG["port"]
    # ldap.base = LDAP_CONFIG["base"]
    # ldap.encryption LDAP_CONFIG["encryption"]

    ldap = Net::LDAP.new(:host => LDAP_CONFIG["host"],
                         :port => LDAP_CONFIG["port"],
                         :encryption => { :method => :simple_tls },
                         :base =>  LDAP_CONFIG["base"],
                         :auth => {
                            :method => :simple,
                            :username => LDAP_CONFIG["admin_username"],
                            :password => LDAP_CONFIG["admin_password"]
                          })


    # if username && password
    #   ldap.auth "#{username}@puhsd.org", password
    # else
    #   ldap.auth LDAP_CONFIG["admin_username"], LDAP_CONFIG["admin_password"]
    # end
    return ldap
  end

  def self.start_import
    #  File.open("#{Rails.root}/tmp/ldapsync.ini", "w")
     system "rake import_user_from_ldap &"
  end


  def self.import_from_ldap(username = nil)

    @ldap = User.ldap_connection
    if username == nil
      @filter = Net::LDAP::Filter.eq('sAMAccountType', '805306368') #Should be faster than multiple attribute query
    else
      filter1 = Net::LDAP::Filter.eq('sAMAccountType', '805306368') #Should be faster than multiple attribute query
      filter2 = Net::LDAP::Filter.eq('sAMAccountName', username.downcase)
      # guid_bin = [object_guid].pack("H*")
      @filter = Net::LDAP::Filter.join(filter1, filter2)
    end
    @attrs = LDAP_CONFIG["read-attributes"]
    puts "before search"
    @ldap.search( :base => @ldap.base, :filter => @filter, :attributes => @attrs, :return_result => false) do |entry|
      user = User.find_or_create_by(objectguid: entry["objectGUID"].first.unpack("H*").first.to_s)

      user.email = (entry.respond_to?(:mail) ?  entry.mail.first.downcase : '')

      user.firstname = (entry.respond_to?(:givenname) ? entry["givenname"].first : '')
      user.lastname = (entry.respond_to?(:sn) ? entry["sn"].first : '' )
      user.username = (entry.respond_to?(:sAMAccountName) ? entry["sAMAccountName"].first : '')
      # user.access_level = 0 if user.access_level > 0

      user.access_level = (entry["dn"].first.match(',OU=Staff,OU=Accounts,DC=PUHSD,DC=ORG') ? 1 : 0 ) if !user.admin?


      if user.changed? && user.email != ''
        # user.ldap_imported_at =  Time.now
        user.save
      end
    end
  end


  def self.from_omniauth(auth)


		user = User.find_by(email: auth.info.email)

    if user == nil then
      puts "nil------"
      user = User.import_from_ldap(auth.info.email.split("@").first)
    end




    return user
    # where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      # user.provider = auth.provider
      # user.uid = auth.uid
      # user.name = auth.info.name
      # user.oauth_token = auth.credentials.token
      # user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      # user.save!
    # end
  end

  def displayname
    return self.firstname + ' ' + self.lastname
  end


end
