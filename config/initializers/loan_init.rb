DATE_FORMAT = '%d %b %Y'
TIME_FORMAT = DATE_FORMAT+ 'at %I:%M %p'

CUSTOM_FIELDS = YAML.load_file(Rails.root.join('config', 'custom_fields.yml'))

# All Countries Codes
COUNTRY_CODES = (ISO3166::Country.countries.sort.map{ |i| i.alpha2 }).freeze

class ActiveSupport::TimeWithZone
	def nice
		self.strftime(TIME_FORMAT)
	end
end

class Date
	def nice
		self.strftime(DATE_FORMAT)
	end
end

class String
	def is_i
		/\A[-+]?\d+\z/ === self
	end
end
