class MakeHitsZero < ActiveRecord::Migration
  def up
	Url.all.each do |u|
		u.update_attribute :hits, 0
	end
  end

  def down
  end
end
