# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EligibilityService, type: :model do
  let(:service) { EligibilityService.new(client, day) }
  let(:client) { FactoryBot.create :client }
  let(:identity) { FactoryBot.create :identity, client: client }
  let(:day) { '2019-06-01' }

  it { expect(service.send(:of_url)).to eq 'https://api.rules.nz/calculate' }

  describe 'presence_values' do
    context 'when has lots of movements in the past' do
      before do
        FactoryBot.create :arrival, carrier_date_time: '2018-01-01', identity: identity

        # 16 day trip away
        FactoryBot.create :departure, carrier_date_time: '2018-05-01', identity: identity
        FactoryBot.create :arrival, carrier_date_time: '2018-05-16', identity: identity
      end
      it { expect(client.movements.count).to eq 3 }
      it { expect(service.send(:presence_values)).to eq('2018-01-01' => true, '2018-05-02' => false, '2018-05-16' => true) }
    end
  end

  describe 'presence_count' do

    subject { service.presence_count(client, day) }

    context 'when not present in nz' do
      before { service.run! }
      it "Adds up the previous 5 years to all be zero" do
        expect(service.days_by_rolling_year).to eq('2015-06-01' => 0, '2016-06-01' => 0, '2017-06-01' => 0, '2018-06-01' => 0, '2019-06-01' => 0)
      end
      it { expect(service.meets_minimum_presence_requirements[day]).to eq(false) }
      it { expect(service.meets_5_year_presence_requirement[day]).to eq(false) }
    end

    context 'when present all the days' do
      before do
        FactoryBot.create :arrival, carrier_date_time: '2011-01-01', identity: identity
        service.run!
      end
      it "Adds up the previous 5 years to all be present" do
        expect(service.days_by_rolling_year).to eq('2015-06-01' => 365, '2016-06-01' => 366, '2017-06-01' => 365, '2018-06-01' => 365, '2019-06-01' => 365)
      end
      it { expect(service.meets_minimum_presence_requirements[day]).to eq(true) }
      it { expect(service.meets_5_year_presence_requirement[day]).to eq(true) }
    end

    context 'when in out of NZ for 4 months' do
      before do
        FactoryBot.create :arrival, carrier_date_time: '2011-01-01', identity: identity
        FactoryBot.create :departure, carrier_date_time: '2016-01-01', identity: identity
        FactoryBot.create :arrival, carrier_date_time: '2016-04-01', identity: identity
        service.run!
      end
      it "works out the absence for 4 months" do
        expect(service.days_by_rolling_year).to eq('2015-06-01' => 365, '2016-06-01' => 276, '2017-06-01' => 365, '2018-06-01' => 365, '2019-06-01' => 365)
      end
      it { expect(service.meets_minimum_presence_requirements[day]).to eq(true) }
      it { expect(service.meets_5_year_presence_requirement[day]).to eq(true) }
    end
  end

  describe 'dates to ask OF for' do
    it { expect(service.send(:years_before, 1)).to eq '2018-06-01' }
    it { expect(service.send(:years_before, 2)).to eq '2017-06-01' }
    it { expect(service.send(:years_before, 3)).to eq '2016-06-01' }
    it { expect(service.send(:years_before, 4)).to eq '2015-06-01' }
  end
end
