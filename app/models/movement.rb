class Movement < ApplicationRecord
  belongs_to :client, optional: true
end
