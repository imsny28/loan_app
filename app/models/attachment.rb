class Attachment < ApplicationRecord
  # has_many_attached :images
  has_one_attached :image

#  belongs_to :customer, :class_name => 'Customer', :foreign_key => 'customer_id'
end
