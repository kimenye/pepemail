class AddProfileFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :company_name, :string
    add_column :users, :website, :string
    add_column :users, :email_address, :string
    add_column :users, :facebook_page, :string
    add_column :users, :twitter_handle, :string
    add_column :users, :phone_number, :string
    add_column :users, :alternate_phone_number, :string
  end
end
