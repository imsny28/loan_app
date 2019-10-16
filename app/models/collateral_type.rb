class CollateralType < ApplicationRecord
  has_many :collaterals, -> { where(archived: false)}
  validates :name, presence: true, uniqueness: true
	has_and_belongs_to_many :attribute_options

	# has_many :attribute_options, through: :collaterals
end
