# frozen_string_literal: true

class Visa < ApplicationRecord
  scope :indefinite, -> { where(VisaType::INDEFINITE_VISA_TYPES.include?(visa_type.visa_type)) }
  scope :finite, -> { !indefinite }

  belongs_to :visa_type
  belongs_to :identity

  validates :start_date, presence: true
  validate :has_expiry_or_is_indefinite?

  # Adds a validation error if the expiry date is not set, unless the visa type
  # is indefinite.
  def has_expiry_or_is_indefinite?
    if expiry_date.nil? && !visa_type.indefinite?
      errors.add(:expiry_date, 'must be present unless the visa is indefinite')
    end
  end
end
