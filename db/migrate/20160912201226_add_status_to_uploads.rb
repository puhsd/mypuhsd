class AddStatusToUploads < ActiveRecord::Migration[5.0]
  def change

    add_column  :uploads, :status_code, :integer, :null => false, :default => 0
    add_column  :uploads, :comment, :string, :null => false, :default => ''
  end
end
