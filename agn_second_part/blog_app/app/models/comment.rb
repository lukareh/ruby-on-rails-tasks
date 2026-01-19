class Comment < ApplicationRecord
  belongs_to :blog
  belongs_to :user

  validates :content, presence: true, length: { minimum: 5 }
  validates :author, presence: true
  validates :user, presence: true
  validate :blog_must_be_published

  private

  # checking if blog is published before adding comment
  def blog_must_be_published
    if blog && !blog.published?
      errors.add(:blog, "must be published to add comments")
    end
  end
end
