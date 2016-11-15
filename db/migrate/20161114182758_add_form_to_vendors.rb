class AddFormToVendors < ActiveRecord::Migration[5.0]
  def change
    add_column :vendors, :logonform, :string
  end
end
