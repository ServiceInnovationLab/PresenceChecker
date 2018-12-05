# frozen_string_literal: true

class Identity < ApplicationRecord
  belongs_to :client
  has_many :movements, dependent: :destroy
end
