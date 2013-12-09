class AddProductTypeToRenewals < ActiveRecord::Migration
  def change
    add_column :renewals, :product_type, :string
  end
end
