# frozen_string_literal: true

class EligibilityService
  def initialize(client, day)
    @client = client
    @day = day
  end

  def run!
    @response = calculate(query)
  end

  def meets_minimum_presence_requirements
    @response['persons'][person_name]['citizenship__meets_minimum_presence_requirements'][@day]
  end

  def meets_each_year_minimum_presence_requirements
    @response['persons'][person_name]['citizenship__meets_each_year_minimum_presence_requirements'][@day]
  end

  def meets_5_year_presence_requirement
    @response['persons'][person_name]['citizenship__meets_5_year_presence_requirement'][@day]
  end

  def days_by_rolling_year
    @response['persons'][person_name]['days_present_in_new_zealand_in_preceeding_year']
  end

  private

  def query
    {
      'persons' => {
        person_name => {
          'citizenship__meets_minimum_presence_requirements' => {
            @day => nil
          },
          'citizenship__meets_each_year_minimum_presence_requirements' => {
            @day => nil
          },
          'citizenship__meets_5_year_presence_requirement' => {
            @day => nil
          },
          'days_present_in_new_zealand_in_preceeding_year' => {
            @day => nil,
            years_before(1) => nil,
            years_before(2) => nil,
            years_before(3) => nil,
            years_before(4) => nil
          },
          'present_in_new_zealand' => presence_values
        }
      },
      'families' => {
        'happy' => {
          'others': ['Ruby']
        }
      },
      'titled_properties' => {
        'home' => {
          'others' => ['Ruby']
        }
      }
    }
  end

  def presence_values
    presence = {}

    @client.movements.order(:carrier_date_time).each do |movement|
      if movement.direction == 'arrival'
        presence[movement.carrier_date_time.to_date.strftime(date_format)] = true
      elsif movement.direction == 'departure'
        # today they're here, tomorrow they're not
        # today = movement.carrier_date_time.to_date.strftime(date_format)
        tomorrow = (movement.carrier_date_time.to_date + 1).strftime(date_format)
        # presence[today] = true
        presence[tomorrow] = false
      end
    end

    presence
  end

  def date_format
    '%Y-%m-%d'
  end

  def years_before(num_years)
    (@day.to_date - num_years.year).strftime(date_format)
  end

  def person_name
    'Ruby'
  end

  def calculate(query)
    JSON.parse(HTTParty.post(of_url, body: query.to_json, headers: headers).body)
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end

  def of_url
    "#{ENV['OPENFISCA_URL']}/calculate"
  end
end
