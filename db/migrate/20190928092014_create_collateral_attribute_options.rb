class CreateCollateralAttributeOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :collateral_attribute_options do |t|
      t.integer :collateral_id
      t.integer :attribute_option_id

      t.timestamps
    end
  end
end
