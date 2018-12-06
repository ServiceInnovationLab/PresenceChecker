# frozen_string_literal: true

require 'application_system_test_case'

class IdentitiesTest < ApplicationSystemTestCase
  setup do
    @identity = identities(:one)
  end

  test 'visiting the index' do
    visit identities_url
    assert_selector 'h1', text: 'Identities'
  end

  test 'creating a Identity' do
    visit identities_url
    click_on 'New Identity'

    fill_in 'Country Of Birth', with: @identity.country_of_birth
    fill_in 'Date Of Birth', with: @identity.date_of_birth
    fill_in 'First Name', with: @identity.first_name
    fill_in 'Identity', with: @identity.identity
    fill_in 'Last Name', with: @identity.last_name
    fill_in 'Second Name', with: @identity.second_name
    fill_in 'Third Name', with: @identity.third_name
    click_on 'Create Identity'

    assert_text 'Identity was successfully created'
    click_on 'Back'
  end

  test 'updating a Identity' do
    visit identities_url
    click_on 'Edit', match: :first

    fill_in 'Country Of Birth', with: @identity.country_of_birth
    fill_in 'Date Of Birth', with: @identity.date_of_birth
    fill_in 'First Name', with: @identity.first_name
    fill_in 'Identity', with: @identity.identity
    fill_in 'Last Name', with: @identity.last_name
    fill_in 'Second Name', with: @identity.second_name
    fill_in 'Third Name', with: @identity.third_name
    click_on 'Update Identity'

    assert_text 'Identity was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Identity' do
    visit identities_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Identity was successfully destroyed'
  end
end
