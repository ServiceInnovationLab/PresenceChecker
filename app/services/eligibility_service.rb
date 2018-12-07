class EligibilityService
  def presence_count(client, day)
    @client = client
    @day = day
    response = calculate(query)
    response['properties'][property_name]['rates_rebate'][year]
  end
  end

  def of_query
    {
      'persons' => {
        'Ruby' => {
          'present_in_new_zealand' => {
            presence_by_day
          },
          'citizenship__meets_each_year_minimum_presence_requirements' => {
            @day: nil
          }
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

  def presence_by_day
    client.movents.order(carrier_datetime) do |movement|
      
    end
  end

  def calculate(query)
    headers = { 'Content-Type' => 'application/json' }
    JSON.parse(HTTParty.post(ENV['OPENFISCA_ORIGIN'], body: query.to_json, headers: headers).body)
  end
end