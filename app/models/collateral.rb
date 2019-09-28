class Collateral < ApplicationRecord
  validates :name, presence: true, uniqueness: true

end
