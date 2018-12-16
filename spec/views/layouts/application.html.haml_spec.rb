# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'layouts/application', type: :view do

  include Devise::Test::ControllerHelpers

  describe 'application view' do
    let(:current_user) { FactoryBot.create :user }

    before do
      assign(:users, current_user)
      sign_in current_user
      render
    end

    it 'displays the application page' do
      render
      expect(rendered).to have_selector('div[class="container"]')
    end
  end
end
