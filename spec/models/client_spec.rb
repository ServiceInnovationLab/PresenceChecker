# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { FactoryBot.create :client, im_client_id: '123', file_number: '890' }

  it { expect(client.im_client_id).to eq '123' }
  it { expect(client.file_number).to eq '890' }

  context 'when a client has identities' do
    before { FactoryBot.create_list(:identity, 10, client: client) }

    it 'we can read those identities' do
      expect(client.identities.size).to eq 10
    end

    context 'and the identities have movements' do
      before do
        FactoryBot.create_list(:departure, 7, identity: client.identities.first)
        FactoryBot.create_list(:arrival, 1, identity: client.identities.first)
      end

      it 'can find movements through identities' do
        expect(client.movements.size).to eq(7 + 1)
      end
    end
  end
end
