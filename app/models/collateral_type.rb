class CollateralType < ApplicationRecord
  has_many :collaterals, -> { where(archived: false)}
  validates :name, presence: true, uniqueness: true

end
