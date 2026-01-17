# clearing old data first
Comment.destroy_all
Blog.destroy_all

puts "Creating 20 blogs (10 published, 10 unpublished)..."

# makeing 10 published blogs with some comments
10.times do |i|
  blog = Blog.create!(
    title: "Published Blog #{i + 1}",
    body: "This is the body content for published blog number #{i + 1}. It contains detailed information about various topics and is ready for public viewing.",
    published: true
  )
  
  # Add 2-4 comments to each published blog
  rand(2..4).times do |j|
    blog.comments.create!(
      author: "Commenter #{j + 1}",
      content: "This is a comment on published blog #{i + 1}. Great content!"
    )
  end
  
  print "."
end

# Create 10 unpublished blogs without comments
10.times do |i|
  Blog.create!(
    title: "Unpublished Blog #{i + 1}",
    body: "This is the body content for unpublished blog number #{i + 1}. It is still in draft mode and not ready for public viewing yet.",
    published: false
  )
  
  print "."
end

puts "\n\nSeeding completed!"
puts "Created #{Blog.count} blogs (#{Blog.published.count} published, #{Blog.unpublished.count} unpublished)"
puts "Created #{Comment.count} comments"
