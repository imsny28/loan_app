class Loan < ApplicationRecord
	include LoanStateMachine
	include LoanFinancialStateMachine

	belongs_to :customer

	has_one :line_item
	has_one :placed_line_item, -> { where(status: "placed")}, class_name: "LineItem"

	accepts_nested_attributes_for :line_item, allow_destroy: true

	# serialize: :line_item


	# has_many :activities, as: :activitable

	def line_item_present?
	end

	def place_line_item!
	end
end
