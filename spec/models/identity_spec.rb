# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Identity, type: :model do
  let(:client) { FactoryBot.create :client }
  let(:identity) { FactoryBot.create :identity, client: client }

  context 'when a client has identities' do
    it { expect(identity.client).to eq client }
    it { expect(identity.client.identities.size).to eq 1 }

    context 'and the identities have movements' do
      before do
        FactoryBot.create_list(:departure, 7, identity: identity)
        FactoryBot.create_list(:arrival, 1, identity: identity)
      end
      it 'can find movements through identities' do
        expect(identity.movements.size).to eq(7 + 1)
      end
    end
  end
end
