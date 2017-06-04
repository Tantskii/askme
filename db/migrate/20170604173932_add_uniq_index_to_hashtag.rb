class AddUniqIndexToHashtag < ActiveRecord::Migration[5.0]
  def change
    add_index :hashtags, :name, unique: true
  end
end
