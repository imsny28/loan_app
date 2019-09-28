class CreateCollaterals < ActiveRecord::Migration[5.2]
  def change
    create_table :collaterals do |t|
      t.string :name
      t.string :display_name
      t.boolean :archived, default: false
      t.decimal :cost_price
      t.integer :collateral_category_id

      t.timestamps
    end
  end
end
