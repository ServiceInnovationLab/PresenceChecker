require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  include Devise::Test::ControllerHelpers
  describe 'user deletion' do
    let(:current_user) { FactoryBot.create :user }
    let(:other_user) { FactoryBot.create :user }

    before do
      assign(:users, [current_user, other_user])
      sign_in current_user
    end

    it 'allows for deletion of users' do
      render
      expect(rendered).to have_link 'delete'
    end

    it 'doesn\'t allow for deletion of self' do
      assign(:current_user, current_user)
      render
      expect(rendered).to have_selector('a[data-method="delete"]', count: 1)
    end
  end
end
