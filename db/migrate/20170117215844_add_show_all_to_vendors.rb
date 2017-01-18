class AddShowAllToVendors < ActiveRecord::Migration[5.0]
  def change
    add_column :vendors, :showtoall, :boolean, :default => false
  end
end
