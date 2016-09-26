class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :firstname
      t.string :lastname
      t.integer :access_level, default: 0, index: true

      t.timestamps
    end
  end
end
