# frozen_string_literal: true

class Movement < ApplicationRecord
  belongs_to :identity
  scope :arrivals, -> { where(direction: 'arrival') }
  scope :departure, -> { where(direction: 'departure') }
end
