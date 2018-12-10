# frozen_string_literal: true

require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { FactoryBot.create(:user) }

  context 'As a user' do
    describe 'POST create' do
      it 'is not possible' do
        expect do
          post(:create)
        end.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end
end
