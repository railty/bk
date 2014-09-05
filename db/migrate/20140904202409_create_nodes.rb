class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :type, :default=>'Node'
      t.references :folder
      t.timestamp :mtime
      t.integer :size
      t.string :md5, :limit => 32
      t.timestamps
    end
  end
end
 