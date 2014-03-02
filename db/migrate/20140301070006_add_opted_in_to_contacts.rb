class AddOptedInToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :opted_in, :boolean
  end
end
