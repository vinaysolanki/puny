class AddIpToUrl < ActiveRecord::Migration
  def change
	add_column :urls, :ip, :string
  end
end
