class CreateRenewals < ActiveRecord::Migration
  def change
    create_table :renewals do |t|
      t.string :first_name
      t.string :last_name
      t.string :postal_address
      t.string :city
      t.string :mobile_number
      t.string :email_address
      t.string :ref
      t.decimal :value
      t.string :registration_number
      t.datetime :renewal_date
      t.datetime :expiry_date
      t.decimal :amount_due
      t.string :renewal_type
      t.decimal :computation

      t.timestamps
    end
  end
end
