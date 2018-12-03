class Identity < ApplicationRecord
  belongs_to :client, optional: true
end
