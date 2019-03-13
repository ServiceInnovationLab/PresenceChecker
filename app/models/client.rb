# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :identities, dependent: :destroy
  has_many :movements, through: :identities
  has_many :visas, through: :identities
  has_many :eligibilities
  

  def arrived_on_this_day?(day)
    movements.arrivals.where('movements.carrier_date_time::date = ?', day).size.positive?
  end
end
