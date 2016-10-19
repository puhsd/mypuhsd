class Password < ApplicationRecord
  belongs_to :user
  belongs_to :vendor


  def self.import(vendor_id,email,username,pass)
    user = User.find_by_email(email)

    if user != nil
      password = Password.where("user_id = ? AND vendor_id = ? ", user.id, vendor_id).first
      password = Password.new if password == nil
      password.vendor_id = vendor_id;
      password.user_id = user.id
      password.username = username
      password.password = pass
      password.save
    end

  end

end
