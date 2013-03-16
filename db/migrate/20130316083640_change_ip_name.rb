class ChangeIpName < ActiveRecord::Migration
  def up
	remove_column :urls, :ip
	add_column :urls, :visitor_ip, :string
  end

  def down
  end
end
