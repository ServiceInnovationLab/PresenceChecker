# frozen_string_literal: true

class Eligibility < ApplicationRecord
  belongs_to :client, touch: true
  validates :calculation_data, presence: true
  validates :minimum_presence, inclusion: { in: [true, false] }
  validates :five_year_presence, inclusion: { in: [true, false] }
  validates :each_year_presence, inclusion: { in: [true, false] }
  validates :present_days_by_rolling_year, presence: true
  validates :mimimum_presence_by_rolling_year, presence: true

  def parse_and_save!(of_response_data)
    self.calculation_data = of_response_data

    # booleans
    self.minimum_presence = calculation_data['citizenship__meets_minimum_presence_requirements'][day_in_of_format]
    self.five_year_presence = calculation_data['citizenship__meets_5_year_presence_requirement'][day_in_of_format]
    self.each_year_presence = calculation_data['citizenship__meets_each_year_minimum_presence_requirements'][day_in_of_format]

    # hash for each rolling year of five
    self.present_days_by_rolling_year = calculation_data['days_present_in_new_zealand_in_preceeding_year']
    self.mimimum_presence_by_rolling_year = calculation_data['citizenship__meets_preceeding_single_year_minimum_presence_requirement']
    save!
  end

  def sum_over_5_years
    self.present_days_by_rolling_year.inject(0) { |sum, tuple| sum += tuple[1] }
  end


  def day_in_of_format
    day.strftime(EligibilityService.date_format)
  end

  def to_s
    "For day #{day} - Eligibility: #{minimum_presence}. Days present: #{present_days_by_rolling_year}"
  end
end
