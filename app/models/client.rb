class Client < ApplicationRecord
  has_many :identities
  has_many :movements, through: :identities
end
