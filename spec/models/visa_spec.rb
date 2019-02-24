# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Visa, type: :model do
  subject { FactoryBot.build(:visa) }

  it 'has a factory which produces valid models by default' do
    expect(subject).to be_valid
  end

  context 'the VisaType is not indefinite' do
    let(:visa_type) { FactoryBot.build(:visa_type, indefinite: false) }

    context 'the expiry date is set' do
      let(:expiry_date) { Time.zone.today + 2.years }
      subject { FactoryBot.build(:visa, visa_type: visa_type, expiry_date: expiry_date) }
      it { should be_valid }
    end

    context 'the expiry date is nil' do
      let(:expiry_date) { nil }
      subject { FactoryBot.build(:visa, visa_type: visa_type, expiry_date: expiry_date) }
      it { should be_invalid }
    end
  end
end
