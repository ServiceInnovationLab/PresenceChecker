# frozen_string_literal: true

require 'rails_helper'
RSpec.describe IdentitiesController, type: :controller do
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

      context 'when searching for an identity' do
        let(:identity) { FactoryBot.create :identity }

        before { get :index, params: { serial_number: identity.serial_number } }

        it 'finds the identity' do
          expect(assigns(:identities)).to eq [identity]
        end
      end

      context 'when searching an exact match for an identity' do
        let(:identity) { FactoryBot.create :identity }

        it 'redirects to the related client\'s show page' do
          expect(get :index, params: { serial_number: identity.serial_number }).to redirect_to(client_path(identity.client))
        end

        it 'doesn\'t redirect without an exact match' do
          expect(get :index, params: { serial_number: "a" }).not_to redirect_to(client_path(identity.client))
        end
      end
    end
  end
end
