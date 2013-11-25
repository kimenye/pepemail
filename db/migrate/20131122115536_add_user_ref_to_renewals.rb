class AddUserRefToRenewals < ActiveRecord::Migration
  def change
    add_reference :renewals, :user, index: true
  end
end
