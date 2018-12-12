# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'identities/_search', type: :view do
  describe 'search view' do
    it 'displays a search field' do
      render
    end
  end
end
