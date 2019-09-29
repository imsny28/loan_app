class Customer < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :ssn, presence: true
  validates :zip_code, presence: true
  validates :address, presence: true

  has_many_attached :images

  has_one :account
  accepts_nested_attributes_for :account
end
