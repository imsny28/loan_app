class AttributeOptionValue < ApplicationRecord

  belongs_to :attribute_option, optional: true

  #has_many :variant_option_values
  validates :name, presence: true, uniqueness: { scope: :attribute_option_id }
end
