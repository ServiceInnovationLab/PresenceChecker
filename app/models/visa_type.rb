# frozen_string_literal: true

class VisaType < ApplicationRecord
  validates :description, presence: true, uniqueness: true
end
