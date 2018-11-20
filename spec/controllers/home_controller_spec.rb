# frozen_string_literal: true

require 'rails_helper'
RSpec.describe HomeController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user)          { FactoryBot.create(:user) }

  context 'not signed in ' do
    describe 'GET index' do
      before { get :index }

      it { expect(response).to redirect_to(new_user_session_path) }
    end
  end

  context 'user is signed in' do
    before { sign_in user }

    describe 'GET index' do
      before { get :index }
      it { expect(response).to have_http_status(:ok) }
    end
  end
end
