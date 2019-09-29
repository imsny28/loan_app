class CreateCollateralTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :collateral_types do |t|
      t.string :name
      t.string :display_name
      t.boolean :archived, default: false

      t.timestamps
    end
  end
end
