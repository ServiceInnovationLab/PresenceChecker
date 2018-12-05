# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :identities, dependent: :destroy
  has_many :movements
end
