class CreateJoinTableCollateralsAttributeOptionValues < ActiveRecord::Migration[5.2]
  def change
    create_join_table :collaterals, :attribute_option_values do |t|
      t.index [:collateral_id, :attribute_option_value_id], unique: true, name: 'idx_collateral_id_on_attribute_option_value_id'
      t.index [:attribute_option_value_id, :collateral_id], unique: true, name: 'idx_collateral_id_onattribute_option_value_id'
    end
  end
end
