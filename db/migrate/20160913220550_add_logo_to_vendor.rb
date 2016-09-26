class AddLogoToVendor < ActiveRecord::Migration[5.0]
  def up
    add_attachment :vendors, :logo
  end

  def down
    remove_attachment :vendors, :logo
  end
end
