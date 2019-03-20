# frozen_string_literal: true

class VisaType < ApplicationRecord
  # This represents the developer understanding of which standard visa types
  # grant indefinite leave to remain in New Zealand. This is pending
  # confirmation by a subject matter expert, and should ultimately be sourced
  # from a lookup table in the database.
  INDEFINITE_VISA_TYPES = ['P', 'A', 'R']

  scope :indefinite, -> { where(visa_type: INDEFINITE_VISA_TYPES) }
  scope :finite, -> { where.not(visa_type: INDEFINITE_VISA_TYPES) }
  validates :description, presence: true, uniqueness: true

  def indefinite? 
    INDEFINITE_VISA_TYPES.include?(visa_type)
  end

  def finite?
    !indefinite?
  end
end
