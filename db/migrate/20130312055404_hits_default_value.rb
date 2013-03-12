class HitsDefaultValue < ActiveRecord::Migration
  def up
	change_column :urls, :hits, :integer, :default => 0
	
  end

  def down
  end
end
