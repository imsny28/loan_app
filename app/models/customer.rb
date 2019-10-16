class Customer < ApplicationRecord
	ICON = 'user'

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
	# has_many :loans, :dependant => :restrict_with_error, index_erros: true, foreign_key: :customer_id
	has_many :loans, foreign_key: :customer_id

	before_update :update_keys

	after_commit :create_activity

	def update_keys
		@update_attributes = self.changes.keys
		@update_attributes.delete("updated_at")
		@update_attributes.delete("archived")
	end

	def create_activity
		unless @update_attributes.blank?
			name = "#{@update_attributes.map(&:humanize).map(&:capitalize).join(', ')} updated"
			Activity.create(name: name, icon:ICON,  activitable: self, customer_id: self.id)
		end
	end
end
