# frozen_string_literal: true

class Movement < ApplicationRecord
  belongs_to :identity
  scope :arrivals, -> { where(direction: 'arrival') }
  scope :departure, -> { where(direction: 'departure') }

  def day
    carrier_date_time.to_date.strftime(date_format)
  end

  def next_day
    (carrier_date_time.to_date + 1).strftime(date_format)
  end

  def date_format
    '%Y-%m-%d'
  end

  def only_absent_for_same_day_or_next?
    identity.client.arrived_on_this_day?(day) || identity.client.arrived_on_this_day?(next_day)
  end
end
