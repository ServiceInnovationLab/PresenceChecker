# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VisaType, type: :model do
  subject { FactoryBot.build(:visa_type) }

  it 'has a factory which produces valid models by default' do
    expect(subject).to be_valid
  end
end
