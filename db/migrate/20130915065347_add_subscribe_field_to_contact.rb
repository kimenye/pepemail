class AddSubscribeFieldToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :subscribe, :boolean
  end
end
