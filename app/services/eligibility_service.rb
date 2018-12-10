# frozen_string_literal: true

class EligibilityService
  def initialize(client, day)
    @client = client
    @day = day
    response = calculate(query)
  end

  def meets_presence_requirements
    response['persons'][person_name]['citizenship__meets_each_year_minimum_presence_requirements']
  end

  def days_present_in_preceeding_year
    response['persons'][person_name]['days_present_in_new_zealand_in_preceeding_year']
  end

  def query
    {
      'persons' => {
        person_name => {
          'citizenship__meets_each_year_minimum_presence_requirements' => {
            @day => nil
          },
          'citizenship__meets_5_year_presence_requirement' => {
            @day => nil
          },
          'citizenship__meets_each_year_minimum_presence_requirements' => {
            @day => nil
          },
          'days_present_in_new_zealand_in_preceeding_year' => {
            @day => nil
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
    date_format = '%Y-%m-%d'
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

  # def presence_by_day
  #    { @day: @client.present_in_nz? }
  # end

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
