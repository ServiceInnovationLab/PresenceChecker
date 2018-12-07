# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ClientsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { FactoryBot.create(:user) }
  let(:client) { FactoryBot.create :client }

  context 'not signed in ' do
    describe 'GET show' do
      before { get :show, params: { id: client.to_param } }

      it { expect(response).to redirect_to(new_user_session_path) }
    end
  end

  context 'user is signed in' do
    before { sign_in user }

    describe 'GET show' do
      before { get :show, params: { id: client.to_param } }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(:client)).to eq client }
    end
  end
end
