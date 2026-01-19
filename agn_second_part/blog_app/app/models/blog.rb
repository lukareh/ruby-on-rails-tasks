class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  # scope to get only published blogs
  scope :published, -> { where(published: true) }
  # scope to get only unpublised blogs
  scope :unpublished, -> { where(published: false) }

  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :body, presence: true, length: { minimum: 10 }
  validates :user, presence: true

  # schedule auto publish job after blog creation
  after_create :schedule_auto_publish

  private

  # schedules job to auto publish blog after 1 hour
  def schedule_auto_publish
    PublishBlogJob.set(wait: 1.hour).perform_later(id)
  end
end
