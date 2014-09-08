class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.boolean :is_folder
      t.references :parent
      t.timestamp :mtime
      t.integer :size, :limit => 8
      t.string :md5, :limit => 32
      t.timestamps
    end
  end
end
 