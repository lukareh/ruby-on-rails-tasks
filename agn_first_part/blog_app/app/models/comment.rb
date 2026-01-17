class Comment < ApplicationRecord
  belongs_to :blog

  validates :content, presence: true, length: { minimum: 5 }
  validates :author, presence: true
  validate :blog_must_be_published

  private

  # checking if blog is published before adding comment
  def blog_must_be_published
    if blog && !blog.published?
      errors.add(:blog, "must be published to add comments")
    end
  end
end
