# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EligibilityService, type: :model do
  describe '#presence_count' do
    let(:service) { EligibilityService.new(client, day) }
    let(:client) { FactoryBot.create :client }

    it { expect(service.of_url).to eq 'https://api.rules.nz/calculate' }

    let(:day) { '2019-06-01' }
    subject { service.presence_count(client, day) }

    context 'not present' do
      it { expect(service.days_present_in_preceeding_year).to eq('2019-06-01': 0) }
      it { expect(service.meets_presence_requirements).to eq('2019-06-01': false) }
    end
  end
end
