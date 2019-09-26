class AttributeOption < ApplicationRecord

  has_many :attribute_option_values

  accepts_nested_attributes_for :attribute_option_values, allow_destroy: true
end
