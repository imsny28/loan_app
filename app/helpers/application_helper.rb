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
end
