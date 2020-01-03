require 'rails_helper'

RSpec.describe Action, type: 'model' do
  subject(:action) { build(:action) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:issue) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
