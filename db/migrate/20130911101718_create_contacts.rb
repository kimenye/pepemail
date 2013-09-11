class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :confirmation_token
      t.timestamp :confirmed_at

      t.timestamps
    end
  end
end
