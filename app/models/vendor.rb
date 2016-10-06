class Vendor < ApplicationRecord
  has_many :passwords;
  has_many :uploads;
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "150x150>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

end
