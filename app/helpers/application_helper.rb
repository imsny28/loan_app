module ApplicationHelper
  def error_for obj, attr_name
    render partial: 'shared/error', locals: { obj: obj, attr_name: attr_name }
  end

  def fetch_attribute_option_values
    AttributeOptionValue.where(archived: false)
  end

  def properties_options obj
    attribute_options_ids = obj.attribute_option_ids || []
    properties = []
    if attribute_options_ids.any?
      attribute_options_ids.each do |attribute_option_id|
        attribute_option_values =obj.attribute_option_values.select { |obj| obj.attribute_option_id == attribute_option_id}
        attribute_option_value = attribute_option_values.first
        attribute_option_value_id = attribute_option_value.id
        hsh = {
          attribute_option_id: attribute_option_id,
          attribute_option_value_id: attribute_option_value_id
        }

        properties << hsh
      end
    else
      hsh = {
        attribute_option_id: nil,
        attribute_option_value_id: nil
      }
      properties << hsh
    end

    properties.to_json
  end

	def modified obj
		obj.updated_at.nice
	end

	def created obj
		obj.created.nice
	end

	def states country_code
		country = ISO3166::Country.find_country_by_alpha2(country_code)
		result = []
		country.states.each do |k, v| result << { 'state_code' => k, 'state_name' => v.name } if v.name.present? end  if country.present?

		result
	end

	def get_state_name country_code, state_code
		states = states(country_code)
		result = states.find{ |hsh| hsh['state_code'] == state_code }
		result['state_name'] unless result.nil?
	end

	def get_country_state_hash array_of_countries
		country_state_hash = []
		array_of_countries.each do |a| country_state_hash << { :country_name => a, :state => states(a) } end
		country_state_hash
	end
end


rails generate model Loan amount:decimal currency:string status:string payoff: 
