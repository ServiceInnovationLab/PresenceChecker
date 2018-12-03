class Client < ApplicationRecord
  has_many :identities, dependent: :destroy
end
