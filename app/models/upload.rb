class Upload < ApplicationRecord
  belongs_to :vendor
  enum status_code: { uploaded: 0, processing: 1, completed: 2, canceled: 3,  error: 4}

  has_attached_file :file, :path => "#{Rails.root}/non-public/uploads/:attachment/:id/:style/:basename.:extension",
                            :url => '/downloads/:id'
  validates_attachment_content_type :file, :content_type => ['text/csv','text/comma-separated-values','text/csv','application/csv','application/excel','application/vnd.ms-excel','application/vnd.msexcel','text/anytext','text/plain']

  validates :file, presence: true

  after_save :create_process

  before_destroy :delete_file

  def delete_file
    Upload.find(self.id).file.destroy
  end

  def create_process
		system "rake import_vendor_info UPLOAD_ID=#{self.id} &"
		# call_rake :import_resorces, :upload_id => self.id
	end

  def rerun
    self.status_code = 0
    self.save
  end


  def uploadPasswords()
    begin
      self.update_columns(status_code: 1)
      require 'csv'
      CSV.foreach(self.file.path) do |row|
        user = User.find_by_email(row[0])

        if user != nil
          password = Password.where("user_id = ? AND vendor_id = ? ", user.id,self.vendor_id).first
          password = Password.new if password == nil
          password.vendor_id = self.vendor_id;
          password.user_id = user.id
          password.username = row[1]
          password.password = row[2]
          password.save
        end

      end
      self.update_columns(status_code: 2)

      self.update_columns(comment: "Completed successfully")

    rescue Exception => e
      self.update_columns(status_code: 4)

      self.update_columns(comment: "#{e.message}\n\n#{e.backtrace.inspect}")

    end
  end

end
