class AttributeOption < ApplicationRecord

  has_many :attribute_option_values, -> { where(archived: false)}
  # has_many :product_attribute_options
  has_and_belongs_to_many :attribute_options, join_table: "attribute_options_collaterals"

  # accepts_nested_attributes_for :attribute_option_values, rejected_if: :name_validate
  accepts_nested_attributes_for :attribute_option_values


  validates :name, presence: true, uniqueness: true

  # before :name_parameterize
  # private
  #
  # def name_parameterize
  #   self.name = self.name.name_parameterize
  # end
  #
  # def name_validate(attributes)
  #   attributes['name'].blank?
  # end
end
