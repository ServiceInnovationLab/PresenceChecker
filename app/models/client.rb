class Client < ApplicationRecord
  has_many :identities

  def self.search(search)
    where("identities.identity LIKE ?", "%#{search}%")
  end
end
