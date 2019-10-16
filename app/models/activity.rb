class Activity < ApplicationRecord
	belongs_to :activitable, polymorphic: true 
end
