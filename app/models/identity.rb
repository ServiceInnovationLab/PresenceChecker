# frozen_string_literal: true

class Identity < ApplicationRecord
  belongs_to :client
  has_many :movements, dependent: :destroy
  has_many :visas, dependent: :destroy
  belongs_to :country_of_birth, class_name: 'Country'
  belongs_to :issuing_state, class_name: 'Country'

  delegate :name, to: :country_of_birth, prefix: true

  delegate :name, to: :issuing_state, prefix: true
end
