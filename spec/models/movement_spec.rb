# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movement, type: :model do
  subject { FactoryBot.build(:movement, direction: 'arrival') }
  let(:arrival) { FactoryBot.create(:movement, direction: 'A') }
  let(:departure) { FactoryBot.create(:movement, direction: 'D') }

  it 'has a factory which produces valid models by default' do
    expect(subject).to be_valid
  end

  it 'recognises when movement direction is A or D' do
    expect(arrival).to be_valid
    expect(departure).to be_valid
    expect(arrival.arrival?).to be true
  end
end