# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'identities/index', type: :view do
#   describe 'identities view' do
#     let(:identity) { FactoryBot.create :identity }
#     it 'lists a number of identities' do
#       expect(identity).to be_truthy
#       expect(identity.first_name).to_not be_empty
#     end
#   end
# end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'identities/index', type: :view do
  let(:client) { FactoryBot.create(:client) }

  before do
    FactoryBot.create_list(:identity, 2)
    assign(:client, client)
    assign(:identities, client.identities)
    render
  end

  it { expect(rendered).to include 'Identities' }
  it { expect(rendered).to include 'Passport No.' }
end
