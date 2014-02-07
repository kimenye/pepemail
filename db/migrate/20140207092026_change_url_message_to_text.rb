class ChangeUrlMessageToText < ActiveRecord::Migration
  def change
  	change_column :urls, :message, :text
  end
end
