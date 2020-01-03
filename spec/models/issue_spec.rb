require 'rails_helper'

RSpec.describe Issue, type: 'model' do
  subject(:issue) { build(:issue) }

  describe 'associations' do
    it { is_expected.to have_many(:actions) }
    it { is_expected.to belong_to(:project) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
