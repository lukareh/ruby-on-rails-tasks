# service to publish a blog
class BlogPublisherService
  attr_reader :blog, :errors

  def initialize(blog)
    @blog = blog
    @errors = []
  end

  # publishes the blog
  def call
    return false if blog.nil?

    if blog.published?
      @errors << "Blog is already published"
      return false
    end

    if blog.update(published: true)
      true
    else
      @errors = blog.errors.full_messages
      false
    end
  end

  # class method for easy calling
  def self.publish(blog)
    new(blog).call
  end
end
