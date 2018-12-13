# frozen_string_literal: true

class Eligibility < ApplicationRecord
  belongs_to :client, touch: true

  def to_s
    "For day #{day} - Eligibility: #{minimum_presence}. Days present: #{present_days_by_rolling_year}"
  end
end
