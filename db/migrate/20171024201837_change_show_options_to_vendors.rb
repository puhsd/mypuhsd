class ChangeShowOptionsToVendors < ActiveRecord::Migration[5.0]
  def change
    add_column :vendors, :showto, :integer, :default => 0
    remove_column :vendors, :showtoall, :boolean, :default => false
  end
end
