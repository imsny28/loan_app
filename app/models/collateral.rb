class Collateral < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :attribute_options, join_table: "collateral_attribute_options"
  has_many :attribute_option_values, through: :attribute_options
end
