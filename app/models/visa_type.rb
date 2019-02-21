# frozen_string_literal: true

class VisaType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
