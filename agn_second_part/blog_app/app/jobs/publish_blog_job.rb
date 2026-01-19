# job to auto publish blog after 1 hour
class PublishBlogJob < ApplicationJob
  queue_as :default

  # publishes blog using service
  def perform(blog_id)
    blog = Blog.find_by(id: blog_id)
    return unless blog

    # only publish if not already published
    unless blog.published?
      BlogPublisherService.publish(blog)
    end
  end
end
