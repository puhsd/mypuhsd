class CreateVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
