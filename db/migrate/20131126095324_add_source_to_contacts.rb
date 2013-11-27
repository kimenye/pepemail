class AddSourceToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :source, :string
  end
end
