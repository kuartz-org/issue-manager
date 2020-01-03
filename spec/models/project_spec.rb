require 'rails_helper'

RSpec.describe Project, type: 'model' do
  subject(:project) { build(:project) }

  describe 'associations' do
    it { is_expected.to have_many(:registrations) }
    it { is_expected.to have_many(:users) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
