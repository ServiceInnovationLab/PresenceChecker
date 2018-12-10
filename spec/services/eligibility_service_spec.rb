# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EligibilityService, type: :model do
  describe '#presence_count' do
    let(:service) { EligibilityService.new(client, day) }
    let(:client) { FactoryBot.create :client }
    let(:identity) { FactoryBot.create :identity, client: client }

    it { expect(service.of_url).to eq 'https://api.rules.nz/calculate' }

    let(:day) { '2019-06-01' }
    # subject { service.presence_count(client, day) }

    # context 'not present' do
    #   it { expect(service.days_present_in_preceeding_year).to eq('2019-06-01': 0) }
    #   it { expect(service.meets_presence_requirements).to eq('2019-06-01': false) }
    # end

    # context 'present' do
    #   before do
    #     FactoryBot.create :movement, carrier_date_time: 100.days.ago
    #   end
    # end

    describe 'presence_values' do
      context 'when has lots of movements in the past' do
        before do
          FactoryBot.create :arrival, carrier_date_time: '2018-01-01', identity: identity

          # 16 day trip away
          FactoryBot.create :departure, carrier_date_time: '2018-05-01', identity: identity
          FactoryBot.create :arrival, carrier_date_time: '2018-05-16', identity: identity
        end
        it { expect(client.movements.count).to eq 3 }
        it { expect(service.presence_values).to eq('2018-01-01' => true, '2018-05-02' => false, '2018-05-16' => true) }
      end
    end
  end
end
