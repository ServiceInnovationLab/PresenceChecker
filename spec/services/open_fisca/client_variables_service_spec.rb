# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenFisca::ClientVariablesService do
  let(:service) { described_class.new(client) }
  let(:client) { FactoryBot.create :client }
  let(:identity) { FactoryBot.create :identity, client: client }
  let(:day) { '2019-06-01' }

  describe '#present_in_new_zealand' do
    context 'when has lots of movements in the past' do
      before do
        FactoryBot.create :arrival, carrier_date_time: '2018-01-01', identity: identity

        # 16 day trip away
        FactoryBot.create :departure, carrier_date_time: '2018-05-01', identity: identity
        FactoryBot.create :arrival, carrier_date_time: '2018-05-16', identity: identity
      end

      it { expect(client.movements.count).to eq 3 }
      it {
        expect(service.present_in_new_zealand)
        .to eq(
        '2018-01-01' => true,
        '2018-05-02' => false,
        '2018-05-16' => true)
      }
    end

    context 'when returning to NZ next day' do
      before do
        FactoryBot.create :arrival, carrier_date_time: '2011-01-01', identity: identity
        FactoryBot.create :departure, carrier_date_time: '2016-04-01', identity: identity
        FactoryBot.create :arrival, carrier_date_time: '2016-04-02', identity: identity
      end

      it { 
        expect(service.present_in_new_zealand)
        .to eq(
          '2011-01-01' => true, 
          '2016-04-02' => true) 
      }
    end

    context 'when returning to NZ same day' do
      before do
        FactoryBot.create :arrival, carrier_date_time: '2011-01-01', identity: identity
        FactoryBot.create :departure, carrier_date_time: '2016-04-01', identity: identity
        FactoryBot.create :arrival, carrier_date_time: '2016-04-01', identity: identity
      end

      it { expect(service.present_in_new_zealand).to eq('2011-01-01' => true, '2016-04-01' => true) }
    end

    context 'when returning to NZ with one day absence' do
      before do
        FactoryBot.create :arrival, carrier_date_time: '2011-01-01', identity: identity
        FactoryBot.create :departure, carrier_date_time: '2016-04-01', identity: identity
        FactoryBot.create :arrival, carrier_date_time: '2016-04-03', identity: identity
      end

      it { expect(service.present_in_new_zealand).to eq('2011-01-01' => true, '2016-04-02' => false, '2016-04-03' => true) }
    end
  end
end
