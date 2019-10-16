class LineItem < ApplicationRecord
	include LineItemStateMachine
	include LineItemFinancialStateMachine

	# belongs_to :order
	belongs_to :loan
	belongs_to :collateral

	serialize :custom_field, Hash


	before_save :map_collateral_properties

	def map_collateral_properties
		debugger
	end
end
