class CreateJoinTableAttibuteOptionCollateralType < ActiveRecord::Migration[5.2]
  def change
    create_join_table :collateral_types, :attribute_options do |t|
      t.index [:collateral_type_id, :attribute_option_id], unique: true, name: 'idx_collateral_type_id_on_attribute_option_id'
      t.index [:attribute_option_id, :collateral_type_id], unique: true, name: 'idx_collateral_type_id_onattribute_option_id'
    end
  end
end
