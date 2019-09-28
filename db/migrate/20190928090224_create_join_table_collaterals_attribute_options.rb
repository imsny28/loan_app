class CreateJoinTableCollateralsAttributeOptions < ActiveRecord::Migration[5.2]
  def change
    create_join_table :collaterals, :attribute_options do |t|
      t.index [:collateral_id, :attribute_option_id], unique: true, name: 'idx_collateral_id_on_attribute_option_id'
      t.index [:attribute_option_id, :collateral_id], unique: true, name: 'idx_collateral_id_onattribute_option_id'
    end
  end
end
