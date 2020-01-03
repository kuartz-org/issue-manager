require 'rails_helper'

RSpec.describe User, type: 'model' do
  subject(:user) { build(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:actions) }
    it { is_expected.to have_many(:registrations) }
    it { is_expected.to have_many(:projects) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end
end
