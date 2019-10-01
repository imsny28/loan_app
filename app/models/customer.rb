class Customer < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :ssn, presence: true
  validates :zip_code, presence: true
  validates :address, presence: true

  # has_many_attached :images 

  has_one :account
  accepts_nested_attributes_for :account

  # has_many :car_images, class_name: "Attachment"
  # has_one :avatar, class_name: "Attachment"

  has_one :attachment, -> { where(archived: false)}
  accepts_nested_attributes_for :attachment

  # has_one :avatar, :through => :attachment  # Edit :needs to be plural same as the has_many relationship
  # accepts_nested_attributes_for :attachment

  # has_many :attachments

end
