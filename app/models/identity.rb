# frozen_string_literal: true

class Identity < ApplicationRecord
  belongs_to :client
  has_many :movements, dependent: :destroy
  belongs_to :country_of_birth, class_name: 'Country'
  belongs_to :issuing_state, class_name: 'Country'

  def country_of_birth_name
    country_of_birth.name
  end

  def issuing_state_name
    issuing_state.name
  end
end
