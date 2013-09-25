class CreateProxies < ActiveRecord::Migration
  def change
    create_table :proxies do |t|
      t.string :form_hash
      t.integer :list_id

      t.timestamps
    end
  end
end
