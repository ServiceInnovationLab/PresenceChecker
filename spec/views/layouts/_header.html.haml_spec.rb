# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'layouts/_header', type: :view do
  include Devise::Test::ControllerHelpers

  describe 'header view' do
    let(:current_user) { FactoryBot.create :user }

    before do
      assign(:users, current_user)
      sign_in current_user
      render
    end

    it 'displays the header' do
      render
      expect(rendered).to include('Signed in as')
    end
  end
end
