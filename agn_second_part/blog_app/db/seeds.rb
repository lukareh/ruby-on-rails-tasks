# Clearing old data first
Comment.destroy_all
Blog.destroy_all
User.destroy_all

puts "Creating hardcoded admin user..."

# Use the hardcoded admin method from User model
admin = User.ensure_admin_exists!

puts "✓ Admin user: #{admin.name} (#{admin.email})"

# Create 5 tech blog posts
puts "\nCreating tech blog posts..."

blog1 = admin.blogs.create!(
  title: "How to Create a Database in PostgreSQL",
  body: "<h2>Getting Started with PostgreSQL</h2>
<p>PostgreSQL is a powerful open-source relational database system. Here's how to create a new database:</p>

<h3>Step 1: Connect to PostgreSQL</h3>
<p>First, open your terminal and connect to PostgreSQL using the psql command:</p>
<p><code>psql -U postgres</code></p>

<h3>Step 2: Create the Database</h3>
<p>Use the CREATE DATABASE command:</p>
<p><code>CREATE DATABASE myapp_db;</code></p>

<h3>Step 3: Verify Creation</h3>
<p>List all databases to confirm:</p>
<p><code>\\l</code></p>

<h3>Step 4: Connect to Your Database</h3>
<p>Switch to your newly created database:</p>
<p><code>\\c myapp_db</code></p>

<p>Now you're ready to create tables and start building your application!</p>",
  published: true
)

blog2 = admin.blogs.create!(
  title: "How to Start a Server on AWS EC2",
  body: "<h2>Deploying Your Application on AWS EC2</h2>
<p>Amazon EC2 provides scalable computing capacity in the cloud. Here's a quick guide to get your server running:</p>

<h3>Prerequisites</h3>
<ul>
<li>AWS account with proper IAM permissions</li>
<li>SSH key pair configured</li>
<li>Security group with required ports open</li>
</ul>

<h3>Step 1: Launch EC2 Instance</h3>
<p>Choose an AMI (Amazon Machine Image), select instance type (t2.micro for free tier), and launch.</p>

<h3>Step 2: Connect via SSH</h3>
<p><code>ssh -i your-key.pem ec2-user@your-instance-ip</code></p>

<h3>Step 3: Install Required Software</h3>
<p>Update packages and install your application dependencies:</p>
<p><code>sudo yum update -y</code></p>

<h3>Step 4: Deploy Your Application</h3>
<p>Clone your repo, install dependencies, and start your server. For Node.js:</p>
<p><code>npm install && npm start</code></p>

<p>Your server is now live on AWS!</p>",
  published: true
)

blog3 = admin.blogs.create!(
  title: "Docker Basics: Containerizing Your Rails Application",
  body: "<h2>Introduction to Docker for Rails</h2>
<p>Docker simplifies deployment by packaging your application with all dependencies. Here's how to containerize a Rails app:</p>

<h3>Create a Dockerfile</h3>
<p>In your Rails root directory, create a Dockerfile:</p>
<p><code>FROM ruby:3.2<br>
WORKDIR /app<br>
COPY Gemfile* .<br>
RUN bundle install<br>
COPY . .<br>
CMD [\"rails\", \"server\", \"-b\", \"0.0.0.0\"]</code></p>

<h3>Build the Image</h3>
<p><code>docker build -t my-rails-app .</code></p>

<h3>Run the Container</h3>
<p><code>docker run -p 3000:3000 my-rails-app</code></p>

<h3>Docker Compose for Multiple Services</h3>
<p>Use docker-compose.yml to manage Rails, PostgreSQL, and Redis together.</p>

<p>Docker makes deployment consistent across environments!</p>",
  published: true
)

blog4 = admin.blogs.create!(
  title: "Git Workflow Best Practices for Teams",
  body: "<h2>Mastering Git for Team Collaboration</h2>
<p>Effective Git workflows keep your team synchronized and your codebase clean.</p>

<h3>Branch Strategy</h3>
<ul>
<li><strong>main</strong> - Production-ready code</li>
<li><strong>develop</strong> - Integration branch</li>
<li><strong>feature/*</strong> - New features</li>
<li><strong>hotfix/*</strong> - Emergency fixes</li>
</ul>

<h3>Essential Commands</h3>
<p><strong>Create feature branch:</strong></p>
<p><code>git checkout -b feature/new-login</code></p>

<p><strong>Keep branch updated:</strong></p>
<p><code>git fetch origin<br>
git rebase origin/develop</code></p>

<p><strong>Interactive rebase for clean history:</strong></p>
<p><code>git rebase -i HEAD~3</code></p>

<h3>Pull Request Guidelines</h3>
<ol>
<li>Write clear descriptions</li>
<li>Keep PRs small and focused</li>
<li>Request reviews from relevant team members</li>
<li>Address feedback promptly</li>
</ol>

<p>Good Git practices prevent merge conflicts and maintain code quality!</p>",
  published: true
)

blog5 = admin.blogs.create!(
  title: "Redis Caching: Boost Your Application Performance",
  body: "<h2>Speed Up Your App with Redis</h2>
<p>Redis is an in-memory data store perfect for caching frequently accessed data.</p>

<h3>Why Use Redis?</h3>
<ul>
<li>Lightning-fast read/write operations</li>
<li>Reduces database load</li>
<li>Supports complex data structures</li>
<li>Built-in expiration for cache invalidation</li>
</ul>

<h3>Installation</h3>
<p><strong>Ubuntu/Debian:</strong></p>
<p><code>sudo apt-get install redis-server</code></p>

<p><strong>macOS:</strong></p>
<p><code>brew install redis</code></p>

<h3>Basic Commands</h3>
<p><strong>Set a value:</strong></p>
<p><code>SET user:1000 \"John Doe\"</code></p>

<p><strong>Get a value:</strong></p>
<p><code>GET user:1000</code></p>

<p><strong>Set with expiration (60 seconds):</strong></p>
<p><code>SETEX session:abc123 60 \"user_data\"</code></p>

<h3>Rails Integration</h3>
<p>Add redis gem and configure cache store in production.rb:</p>
<p><code>config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }</code></p>

<p>Redis can improve response times by 10-100x for cached data!</p>",
  published: false
)

puts "✓ Created #{Blog.count} tech blog posts"
puts "  - #{Blog.published.count} published"
puts "  - #{Blog.unpublished.count} draft"
puts "\n✅ Database seeding complete!"
