# frozen_string_literal: true

class Movement < ApplicationRecord
  belongs_to :identity
  has_one :client, through: :identity

  scope :arrivals, -> { where(direction: 'arrival') }
  scope :departure, -> { where(direction: 'departure') }

  def day
    carrier_date_time.to_date.strftime(EligibilityService.date_format)
  end

  def next_day
    (carrier_date_time.to_date + 1).strftime(EligibilityService.date_format)
  end

  def only_absent_for_same_day_or_next?
    identity.client.arrived_on_this_day?(day) || identity.client.arrived_on_this_day?(next_day)
  end

  def next_movement
    client.movements
      .where('carrier_date_time > ?', carrier_date_time)
      .order(:carrier_date_time)
      .limit(1)
      &.first
  end

  def presence_status_end
    # If this was a arrival, when did they next depart?
    # If this was a departure, when did they return?
    next_movement&.carrier_date_time
  end
end
