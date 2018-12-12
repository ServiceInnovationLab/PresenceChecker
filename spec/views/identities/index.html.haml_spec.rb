# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'identities/index', type: :view do
  describe 'identities view' do
    let(:identity) { FactoryBot.create :identity }
    it 'lists a number of identities' do
      expect(identity).to be_truthy
      expect(identity.family_name).to_not be_empty
      expect(identity.first_name).to_not be_empty
    end
  end
end
