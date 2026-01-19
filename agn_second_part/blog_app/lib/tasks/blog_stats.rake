# rake task to print blog statistics
namespace :blogs do
  desc "print published and unpublished blog counts"
  task stats: :environment do
    published_count = Blog.published.count
    unpublished_count = Blog.unpublished.count
    total_count = Blog.count

    puts "\n========== Blog Statistics =========="
    puts "Total Blogs: #{total_count}"
    puts "Published Blogs: #{published_count}"
    puts "Unpublished Blogs: #{unpublished_count}"
    puts "====================================\n"
  end
end
