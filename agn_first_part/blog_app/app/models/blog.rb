class Blog < ApplicationRecord
  has_many :comments, dependent: :destroy

  # scope to get only published blogs
  scope :published, -> { where(published: true) }
  # scope to get only unpublised blogs
  scope :unpublished, -> { where(published: false) }

  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :body, presence: true, length: { minimum: 10 }
end
