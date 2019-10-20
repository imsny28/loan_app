class Account < ApplicationRecord
  belongs_to :customer, optional: true
	validates :rountine_number, presence: true, uniqueness: true
	validates :account_number, presence: true, uniqueness: true
end
