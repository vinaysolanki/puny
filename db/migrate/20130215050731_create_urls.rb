class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :url
      t.string :key
      t.integer :hits

      t.timestamps
    end
  end
end
