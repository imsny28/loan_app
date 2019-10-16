class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :payload
      t.string :icon
      t.integer :customer_id
      t.integer :activitable_id
      t.string :activitable_type

      t.timestamps
    end
  end
end
