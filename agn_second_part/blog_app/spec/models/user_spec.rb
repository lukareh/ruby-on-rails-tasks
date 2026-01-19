require 'rails_helper'

RSpec.describe User, type: :model do
  # test associations
  describe 'associations' do
    it { should have_many(:blogs).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  # test validations
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
  end

  # test admin check
  describe '#admin?' do
    it 'returns true for admin users' do
      user = create(:user, :admin)
      expect(user.admin?).to be true
    end

    it 'returns false for regular users' do
      user = create(:user)
      expect(user.admin?).to be false
    end
  end
end
