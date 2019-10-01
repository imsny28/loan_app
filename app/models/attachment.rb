class Attachment < ApplicationRecord
  # has_many_attached :images
  has_one_attached :image
  has_one_attached :avatar
  # belongs_to :customer, :class_name => 'Customer', :foreign_key => 'customer_id'

  belongs_to :customer
end
