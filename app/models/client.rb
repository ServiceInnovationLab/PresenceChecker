class Client < ApplicationRecord
  has_many :identities, dependent: :destroy
  has_many :movements, through: :identities
end
