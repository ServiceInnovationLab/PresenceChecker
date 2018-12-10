# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Country, type: :model do
  let(:country) { FactoryBot.create :country }
  let(:identity) { FactoryBot.create :identity, country_of_birth: country, issuing_state: country }

  it { expect(identity.country_of_birth).to eq country }
  it { expect(identity.issuing_state).to eq country }
end
