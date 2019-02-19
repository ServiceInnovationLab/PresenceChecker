# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :identities, dependent: :destroy
  has_many :movements, through: :identities
  has_many :eligibilities

  def arrived_on_this_day?(day)
    movements.arrivals.where(
      'movements.carrier_date_time::date = ?', day).size.positive?
  end

  def eligible?(day)
    eligible_on_day(day)&.minimum_presence
  end
  
  def eligible_on_day(day)
    eligible = eligibilities.find_by(day: day)
    eligible = EligibilityService.new(self, day).run! unless eligible
    eligible
  end

  def to_s
  end
end
