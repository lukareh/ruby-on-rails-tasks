require 'rails_helper'

RSpec.describe Comment, type: :model do
  # test associations
  describe 'associations' do
    it { should belong_to(:blog) }
  end

  # test validations
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:author) }
    it { should validate_length_of(:content).is_at_least(5) }
  end

  # test custom validations
  describe 'custom validations' do
    context 'when blog is published' do
      let(:blog) { create(:blog, :published) }

      it 'allows comment creation' do
        comment = build(:comment, blog: blog)
        expect(comment).to be_valid
      end
    end

    context 'when blog is not published' do
      let(:blog) { create(:blog, :unpublished) }

      it 'does not allow comment creation' do
        comment = build(:comment, blog: blog)
        expect(comment).not_to be_valid
        expect(comment.errors[:blog]).to include("must be published to add comments")
      end
    end
  end
end
