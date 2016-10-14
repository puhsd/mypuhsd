class Vendor < ApplicationRecord
  has_many :passwords;
  has_many :uploads;
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "150x150>" }, default_url: "/logos/original/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  before_destroy :cleanup

  def cleanup
    #remove logos
    Vendor.find(id).logo.destroy
    #remove uploads
    Upload.where(:vendor_id => self.id).destroy_all
    #remove passwords
    Password.where(:vendor_id => self.id).destroy_all

  end

  def remove_logo
    self.logo.destroy
    self.logo.clear
    self.save
  end

end
