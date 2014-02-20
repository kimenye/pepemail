class AddReceiptNotifiedToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :receipt, :boolean
  end
end
