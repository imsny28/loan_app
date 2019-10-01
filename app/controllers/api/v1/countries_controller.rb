class Api::V1::CountriesController < ApplicationController
  def index
    render json: ISO3166::Country.countries.sort.map{|i| { label: i.name, value: i.alpha2 }}
  end

  def show
    states = []
    country = ISO3166::Country.find_country_by_alpha2(params[:id])
    if country.present?
			country.states.each do |k, v|
				states << { label: v.name, value: k } if v.name.present?
			end
    else
      render json: { error: 'country code is not available' }, status: :unprocessable_entity
    end
  end

  def countries_with_states
    countries_with_states = []
    COUNTRY_CODES.each do |country_code|
      states = []
      country = ISO3166::Country.find_country_by_alpha2(country_code)
      country.states.each do |k, v| states << {k => v.name} if v.name.present? end if country.present?
      countries_with_states << {"#{country_code}" => [country.name, states: states] }
    end
    render json: countries_with_states
  end
end
