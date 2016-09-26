class CreatePasswords < ActiveRecord::Migration[5.0]
  def change
    create_table :passwords do |t|
      t.references :user, foreign_key: true
      t.references :vendor, foreign_key: true
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
