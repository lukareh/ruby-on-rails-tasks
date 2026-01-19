require 'rails_helper'

RSpec.describe Blog, type: :model do
  # test associations
  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
  end

  # test validations
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:title).is_at_least(3).is_at_most(200) }
    it { should validate_length_of(:body).is_at_least(10) }
  end

  # test scopes
  describe 'scopes' do
    let!(:published_blog) { create(:blog, :published) }
    let!(:unpublished_blog) { create(:blog, :unpublished) }

    it 'returns only published blogs' do
      expect(Blog.published).to include(published_blog)
      expect(Blog.published).not_to include(unpublished_blog)
    end

    it 'returns only unpublished blogs' do
      expect(Blog.unpublished).to include(unpublished_blog)
      expect(Blog.unpublished).not_to include(published_blog)
    end
  end

  # test callbacks
  describe 'callbacks' do
    it 'schedules auto publish job after creation' do
      expect {
        create(:blog)
      }.to have_enqueued_job(PublishBlogJob).on_queue('default')
    end
  end
end
