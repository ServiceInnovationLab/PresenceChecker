# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'requires good passwords' do
    it 'accepts good passwords' do
      expect { FactoryBot.create :user, password: 'P@ssw0rd}' }.not_to raise_error
    end
    it 'rejects blank passwords' do
      expect { FactoryBot.create :user, password: '' }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'rejects short passwords' do
      expect { FactoryBot.create :user, password: 'P@0' }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'rejects alpha only' do
      expect { FactoryBot.create :user, password: 'Password}' }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'rejects when no number' do
      expect { FactoryBot.create :user, password: 'P@ssword}' }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'rejects when no Upper case' do
      expect { FactoryBot.create :user, password: 'p@ssw0rd}}' }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
