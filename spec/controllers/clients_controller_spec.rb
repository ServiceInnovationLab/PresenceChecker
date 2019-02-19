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
    before { Rails.application.load_seed }

    before { sign_in user }

    describe 'GET show' do
      before { get :show, params: { id: client.to_param } }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(:client)).to eq client }
    end

    describe 'get eligibility' do
      let(:day) { '2019-01-01' }

      let(:identity) { FactoryBot.create :identity, client: client }

      before { FactoryBot.create :arrival, identity: identity, carrier_date_time: '2011-12-31' }

      subject { JSON.parse(response.body)[day] }

      it { expect(response).to have_http_status(:ok) }

      context 'with no holidays data' do
        before { get :eligibility, format: :json, params: { client_id: client.to_param, day: day } }

        it { expect(subject['meetsMinimumPresence']).to eq(true) }
        it do
          expect(subject['last5Years']).to eq(
            '2019-01-01' => true,
            '2018-01-01' => true,
            '2017-01-01' => true,
            '2016-01-01' => true,
            '2015-01-01' => true
          )
        end
        it do
          expect(subject['daysInNZ']).to eq(
            '2019-01-01' => 365,
            '2018-01-01' => 365,
            '2017-01-01' => 366,
            '2016-01-01' => 365,
            '2015-01-01' => 365
          )
        end
      end

      context 'person with a one year absence' do
        before do
          FactoryBot.create :departure, identity: identity, carrier_date_time: '2013-12-31'
          FactoryBot.create :arrival, identity: identity, carrier_date_time: '2014-12-31'
          get :eligibility, format: :json, params: { client_id: client.to_param, day: '2019-01-01' }
        end

        it { expect(subject['meetsMinimumPresence']).to eq(false) }
        it do
          expect(subject['last5Years']).to eq(
            '2019-01-01' => true,
            '2018-01-01' => true,
            '2017-01-01' => true,
            '2016-01-01' => true,
            '2015-01-01' => false
          )
        end
        # there's a 2, the day they left and the day they returned both count
        it do
          expect(subject['daysInNZ']).to eq(
            '2019-01-01' => 365,
            '2018-01-01' => 365,
            '2017-01-01' => 366,
            '2016-01-01' => 365,
            '2015-01-01' => 2
          )
        end
      end

      context 'person with days absent' do
        before do
          # trip one
          FactoryBot.create :departure, identity: identity, carrier_date_time: '2017-05-10'
          FactoryBot.create :arrival, identity: identity, carrier_date_time: '2017-08-18'
          # trip two
          FactoryBot.create :departure, identity: identity, carrier_date_time: '2018-12-21'
          FactoryBot.create :arrival, identity: identity, carrier_date_time: '2018-12-24'
          get :eligibility, format: :json, params: { client_id: client.to_param, day: '2019-01-01' }
        end

        it { expect(subject['meetsMinimumPresence']).to eq(true) }
        it {
          expect(subject['last5Years']).to eq(
            '2019-01-01' => true,
            '2018-01-01' => true,
            '2017-01-01' => true,
            '2016-01-01' => true,
            '2015-01-01' => true
          )
        }
        it {
          expect(subject['daysInNZ']).to eq(
            '2019-01-01' => 363,
            '2018-01-01' => 266,
            '2017-01-01' => 366,
            '2016-01-01' => 365,
            '2015-01-01' => 365
          )
        }
      end

      ###### Test scenario #4 #######
      context 'Customer has three passports, same Client ID' do
        it {
          valid_date = Date.new(2017, 10, 2)
          client = Client.find_by(im_client_id: '12345')

          get :eligibility, format: :json, params: { client_id: client.to_param, day: valid_date.to_s }
          res = JSON.parse(response.body)[valid_date.to_s]

          expect(res['meetsMinimumPresence']).to eq(true)
          expect(res['eachYearPresence']).to eq(true)
          expect(res['meetsFiveYearPresence']).to eq(true)
          expect(res['last5Years']).to eq(
            valid_date.to_s => true,
            valid_date.prev_year.to_s => true,
            valid_date.prev_year(2).to_s => true,
            valid_date.prev_year(3).to_s => true,
            valid_date.prev_year(4).to_s => true
          )
        }
        it {
          invalid_date = Date.new(2017, 10, 1)
          client = Client.find_by(im_client_id: '12345')

          get :eligibility, format: :json, params: { client_id: client.to_param, day: invalid_date.to_s }
          res = JSON.parse(response.body)[invalid_date.to_s]

          expect(res['meetsMinimumPresence']).to eq(false)
          expect(res['eachYearPresence']).to eq(false)
          expect(res['meetsFiveYearPresence']).to eq(true)
          expect(res['last5Years']).to eq(
            invalid_date.to_s => true,
            invalid_date.prev_year.to_s => true,
            invalid_date.prev_year(2).to_s => true,
            invalid_date.prev_year(3).to_s => true,
            invalid_date.prev_year(4).to_s => false
          )
        }
      end

      ###### Test scenario #8 #######
      context 'Customers are away for periods of time, dates tested in Bruteforce, meets presence requirements' do
        it {
          valid_date = Date.new(2018, 11, 5)
          client = Client.find_by(im_client_id: '54321')

          get :eligibility, format: :json, params: { client_id: client.to_param, day: valid_date.to_s }
          res = JSON.parse(response.body)[valid_date.to_s]

          expect(res['meetsMinimumPresence']).to eq(true)
          expect(res['eachYearPresence']).to eq(true)
          expect(res['meetsFiveYearPresence']).to eq(true)
          expect(res['last5Years']).to eq(
            valid_date.to_s => true,
            valid_date.prev_year.to_s => true,
            valid_date.prev_year(2).to_s => true,
            valid_date.prev_year(3).to_s => true,
            valid_date.prev_year(4).to_s => true
          )
        }
      end
      ###### Test scenario #9 #######
      context 'Customers are away for periods of time, dates tested in Bruteforce, does not meet presence requirements' do
        it {
          invalid_date = Date.new(2018, 11, 5)
          client = Client.find_by(im_client_id: '56789')

          get :eligibility, format: :json, params: { client_id: client.to_param, day: invalid_date.to_s }
          res = JSON.parse(response.body)[invalid_date.to_s]

          expect(res['meetsMinimumPresence']).to eq(false)
          expect(res['eachYearPresence']).to eq(false)
          expect(res['meetsFiveYearPresence']).to eq(true)
          expect(res['last5Years']).to eq(
            invalid_date.to_s => true,
            invalid_date.prev_year.to_s => false,
            invalid_date.prev_year(2).to_s => true,
            invalid_date.prev_year(3).to_s => true,
            invalid_date.prev_year(4).to_s => true
          )
        }
      end
      ###### Test scenario #10 #######
      context 'Multiple 20 week vacations, Only eligible between June 8th and September 27' do
        it {
          valid_date = Date.new(2018, 7, 8)
          client = Client.find_by(im_client_id: '581119')

          get :eligibility, format: :json, params: { client_id: client.to_param, day: valid_date.to_s }
          res = JSON.parse(response.body)[valid_date.to_s]

          expect(res['meetsMinimumPresence']).to eq(true)
          expect(res['eachYearPresence']).to eq(true)
          expect(res['meetsFiveYearPresence']).to eq(true)
          expect(res['last5Years']).to eq(
            valid_date.to_s => true,
            valid_date.prev_year.to_s => true,
            valid_date.prev_year(2).to_s => true,
            valid_date.prev_year(3).to_s => true,
            valid_date.prev_year(4).to_s => true
          )
        }
        it {
          invalid_date = Date.new(2018, 3, 5)
          client = Client.find_by(im_client_id: '581119')

          get :eligibility, format: :json, params: { client_id: client.to_param, day: invalid_date.to_s }
          res = JSON.parse(response.body)[invalid_date.to_s]
          expect(res['meetsMinimumPresence']).to eq(false)
          expect(res['eachYearPresence']).to eq(false)
          expect(res['meetsFiveYearPresence']).to eq(true)
          expect(res['last5Years']).to eq(
            invalid_date.to_s => false,
            invalid_date.prev_year.to_s => true,
            invalid_date.prev_year(2).to_s => true,
            invalid_date.prev_year(3).to_s => true,
            invalid_date.prev_year(4).to_s => false
          )
        }
      end
      ####### Test scenario #12 #######
      context 'Only one period overseas which was short enough' do
        it {
          valid_date = Date.new(2020, 6, 3)
          client = Client.find_by(im_client_id: '821313')

          get :eligibility, format: :json, params: { client_id: client.to_param, day: valid_date.to_s }
          res = JSON.parse(response.body)[valid_date.to_s]
          
          expect(res['meetsMinimumPresence']).to eq(true)
          expect(res['eachYearPresence']).to eq(true)
          expect(res['meetsFiveYearPresence']).to eq(true)
          expect(res['last5Years']).to eq(
            valid_date.to_s => true,
            valid_date.prev_year.to_s => true,
            valid_date.prev_year(2).to_s => true,
            valid_date.prev_year(3).to_s => true,
            valid_date.prev_year(4).to_s => true
          )
        }
      end
      ####### Test scenario #13 #######
      context 'Was overseas for more than 1 year' do
        it {
          valid_date = Date.new(2018, 7, 8)
          client = Client.find_by(im_client_id: '723123')

          get :eligibility, format: :json, params: { client_id: client.to_param, day: valid_date.to_s }
          res = JSON.parse(response.body)[valid_date.to_s]

          expect(res['meetsMinimumPresence']).to eq(false)
          expect(res['eachYearPresence']).to eq(false)
          expect(res['meetsFiveYearPresence']).to eq(true)
          expect(res['last5Years']).to eq(
            valid_date.to_s => true,
            valid_date.prev_year.to_s => false,
            valid_date.prev_year(2).to_s => true,
            valid_date.prev_year(3).to_s => true,
            valid_date.prev_year(4).to_s => true
          )
        }
      end
    end
  end
end
