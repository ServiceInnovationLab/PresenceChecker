# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'identities/_search', type: :view do
  describe 'search view' do
    it 'displays a search form' do
      render
      expect(rendered).to have_selector('form[id="search-form"]', count: 1)
    end
  end
end
