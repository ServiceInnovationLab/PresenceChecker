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

    describe 'get eligibility' do
      let(:identity) { FactoryBot.create :identity, client: client }
      before do
        Timecop.freeze(Time.local(2019))

        FactoryBot.create :arrival, identity: identity, carrier_date_time: 7.years.ago
      end

      after do
        Timecop.return
      end

      subject { JSON.parse(response.body)['2019-01-01'] }

      it { expect(response).to have_http_status(:ok) }

      context 'with no holidays data' do
        before do
          get :eligibility, format: :json, params: { client_id: client.to_param, day: '2019-01-01' }
        end
        it { expect(subject['meetsMinimumPresence']).to eq(true) }
        it { expect(subject['last5Years']).to eq([true, true, true, true, true]) }
        it { expect(subject['daysInNZ']).to eq([365, 365, 366, 365, 365]) }
      end

      context 'person with a one year absence' do
        before do
          FactoryBot.create :departure, identity: identity, carrier_date_time: 4.years.ago
          FactoryBot.create :arrival, identity: identity, carrier_date_time: 3.years.ago
          get :eligibility, format: :json, params: { client_id: client.to_param, day: '2019-01-01' }
        end
        it { expect(subject['meetsMinimumPresence']).to eq(false) }
        it { expect(subject['last5Years']).to eq([true, false, true, true, true]) }
        # there's a 2, the day they left and the day they returned both count
        it { expect(subject['daysInNZ']).to eq([364, 2, 366, 365, 365]) }
      end

      context 'person with days absent' do
        before do
          # trip one
          FactoryBot.create :departure, identity: identity, carrier_date_time: 600.days.ago
          FactoryBot.create :arrival, identity: identity, carrier_date_time: 500.days.ago
          # trip two
          FactoryBot.create :departure, identity: identity, carrier_date_time: 10.days.ago
          FactoryBot.create :arrival, identity: identity, carrier_date_time: 7.days.ago
          get :eligibility, format: :json, params: { client_id: client.to_param, day: '2019-01-01' }
        end
        it { expect(subject['meetsMinimumPresence']).to eq(true) }
        it { expect(subject['last5Years']).to eq([true, true, true, true, true]) }
        it { expect(subject['daysInNZ']).to eq([365, 365, 366, 266, 363]) }
      end
    end
  end
end
