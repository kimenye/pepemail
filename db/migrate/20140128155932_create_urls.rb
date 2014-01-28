class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :title
      t.timestamp :from
      t.timestamp :to
      t.string :message
      t.integer :num_clicks
      t.string :success_url
      t.string :expired_url

      t.timestamps
    end
  end
end
