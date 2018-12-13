# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EligibilityService, type: :model do
  let(:service) { EligibilityService.new(client, day, 1) }
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

    context 'when returning to NZ next day' do
      before do
        FactoryBot.create :arrival, carrier_date_time: '2011-01-01', identity: identity
        FactoryBot.create :departure, carrier_date_time: '2016-04-01', identity: identity
        FactoryBot.create :arrival, carrier_date_time: '2016-04-02', identity: identity
      end
      it { expect(service.send(:presence_values)).to eq('2011-01-01' => true, '2016-04-02' => true) }
    end

    context 'when returning to NZ same day' do
      before do
        FactoryBot.create :arrival, carrier_date_time: '2011-01-01', identity: identity
        FactoryBot.create :departure, carrier_date_time: '2016-04-01', identity: identity
        FactoryBot.create :arrival, carrier_date_time: '2016-04-01', identity: identity
      end
      it { expect(service.send(:presence_values)).to eq('2011-01-01' => true, '2016-04-01' => true) }
    end
    context 'when returning to NZ with one day absence' do
      before do
        FactoryBot.create :arrival, carrier_date_time: '2011-01-01', identity: identity
        FactoryBot.create :departure, carrier_date_time: '2016-04-01', identity: identity
        FactoryBot.create :arrival, carrier_date_time: '2016-04-03', identity: identity
      end
      it { expect(service.send(:presence_values)).to eq('2011-01-01' => true, '2016-04-02' => false, '2016-04-03' => true) }
    end
  end

  describe 'presence_count' do
    subject { service.presence_count(client, day) }

    it 'saves eligiblity only once' do
      expect { service.run! }.to change { Eligibility.count }.by(1)
      expect { service.run! }.not_to change { Eligibility.count }
    end

    subject { Eligibility.last }

    describe 'fetching' do
      context 'when not present in nz' do
        before { service.run! }

        it 'Adds up the previous 5 years to all be zero' do
          expect(subject.present_days_by_rolling_year).to eq('2015-06-01' => 0, '2016-06-01' => 0, '2017-06-01' => 0, '2018-06-01' => 0, '2019-06-01' => 0)
        end
        it { expect(subject.minimum_presence).to eq(false) }
        it { expect(subject.five_year_presence).to eq(false) }
        it { expect(subject.each_year_presence).to eq(false) }
      end

      context 'when present all the days' do
        before do
          FactoryBot.create :arrival, carrier_date_time: '2011-01-01', identity: identity
          service.run!
        end

        it 'Adds up the previous 5 years to all be present' do
          expect(subject.present_days_by_rolling_year).to eq('2015-06-01' => 365, '2016-06-01' => 366, '2017-06-01' => 365, '2018-06-01' => 365, '2019-06-01' => 365)
        end
        it { expect(subject.minimum_presence).to eq(true) }
        it { expect(subject.five_year_presence).to eq(true) }
        it { expect(subject.each_year_presence).to eq(true) }
      end

      context 'when in out of NZ for 4 months' do
        before do
          FactoryBot.create :arrival, carrier_date_time: '2011-01-01', identity: identity
          FactoryBot.create :departure, carrier_date_time: '2016-01-01', identity: identity
          FactoryBot.create :arrival, carrier_date_time: '2016-04-01', identity: identity
          service.run!
        end

        it 'works out the absence for 4 months' do
          expect(subject.present_days_by_rolling_year).to eq('2015-06-01' => 365, '2016-06-01' => 276, '2017-06-01' => 365, '2018-06-01' => 365, '2019-06-01' => 365)
        end
        it { expect(subject.minimum_presence).to eq(true) }
        it { expect(subject.five_year_presence).to eq(true) }
        it { expect(subject.each_year_presence).to eq(true) }
      end
    end
  end

  describe 'dates to ask OF for' do
    it { expect(service.send(:years_before, '2019-06-01', 1)).to eq '2018-06-01' }
    it { expect(service.send(:years_before, '2019-06-01', 2)).to eq '2017-06-01' }
    it { expect(service.send(:years_before, '2019-06-01', 3)).to eq '2016-06-01' }
    it { expect(service.send(:years_before, '2019-06-01', 4)).to eq '2015-06-01' }
  end
end
