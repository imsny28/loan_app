class LineItem < ApplicationRecord
	include LineItemStateMachine
	include LineItemFinancialStateMachine

	belongs_to :loan
	belongs_to :collateral

	serialize :custom_field, Hash
	before_save :map_collateral_properties

	before_validation do
		@collateral = Collateral.find(self.collateral_id) if self.collateral_id
	end

	def map_collateral_properties
		self.name = @collateral.name
		self.collateral_type = @collateral.collateral_type.name
		self.custom_field = @collateral.attribute_options.as_json(only: [ :name ], include: { attribute_option_values:{  only: [:name] }})
	end
end
