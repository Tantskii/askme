class DeleteMultipleIndex < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, [:username, :email]
  end
end
