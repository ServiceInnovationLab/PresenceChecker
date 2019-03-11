# frozen_string_literal: true

class Movement < ApplicationRecord
  belongs_to :identity
  scope :arrivals, -> { where(direction: 'arrival') }
  scope :departure, -> { where(direction: 'departure') }
  validates_inclusion_of :direction, in: %w( arrival A departure D ), message: "%{value} is not a valid direction"

  def arrival?(direction)
    ['arrival', 'A'].include? direction
  end

  def departure?(direction)
    ['departure', 'D'].include? direction
  end

  def day
    carrier_date_time.to_date.strftime(EligibilityService.date_format)
  end

  def next_day
    (carrier_date_time.to_date + 1).strftime(EligibilityService.date_format)
  end

  def only_absent_for_same_day_or_next?
    identity.client.arrived_on_this_day?(day) || identity.client.arrived_on_this_day?(next_day)
  end
end
