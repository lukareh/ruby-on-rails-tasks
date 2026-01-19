# Blog App

A Ruby on Rails blog application with blogs and comments functionality.

## Getting Started

This application demonstrates CRUD operations for blogs, nested comments, published/unpublished status, validations, and RESTful routing.

## Setup Instructions (For New PC)

1. **Extract the zip file**
```bash
unzip blog_app_assignment.zip
cd blog_app
```

2. **Install Ruby dependencies**
```bash
bundle install
```

3. **Create master key** (if missing)
```bash
# Create a new master key or use dummy credentials
EDITOR="echo 'secret_key_base: $(rails secret)' >" rails credentials:edit
# Or simply create an empty master.key
echo "$(openssl rand -hex 32)" > config/master.key
```

4. **Setup database**
```bash
rails db:create
rails db:migrate
rails db:seed
```

5. **Start the server**
```bash
rails server
```

6. **Visit the application**
```
http://localhost:3000
```

### Prerequisites

- Ruby 4.0.1 or higher
- Rails 8.1.2 or higher
- SQLite3
- Bundler

### Installation

1. Install dependencies:
```bash
bundle install
```

2. Setup database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

3. Start the server:
```bash
rails server
```

4. 4. Visit http://localhost:3000/blogs

## Available Scripts

### Database Commands
```bash
rails db:create
rails db:migrate
rails db:seed
rails db:reset
rails db:rollback
```

### Server Commands
```bash
rails server
rails s
rails s -p 3001
```

### Console
```bash
rails console
rails c
```

### Routes
```bash
rails routes
rails routes | grep blogs
```

### Generators
```bash
rails generate model ModelName field:type
rails generate controller ControllerName
rails generate scaffold ModelName field:type
rails generate migration MigrationName
```

## Additional Commands

### Testing in Console
```bash
rails console
```

Example queries:
```ruby
Blog.published

blog = Blog.new(title: "Test", body: "Test content")
blog.valid?

blog = Blog.published.first
blog.comments.create(author: "John", content: "Great post!")

Blog.where(published: true)
Blog.find_by(title: "Published Blog 1")
Blog.limit(5)
Blog.order(created_at: :desc)
```

## Features

- CRUD operations for blogs
- Nested comments under blogs
- Published/Unpublished status with scopes
- Validations (blogs and comments)
- RESTful routing
- API endpoints (JSON support)
- Seed data (20 blogs, comments)

## Models & Database

### Blog
- `title` (string) - required, 3-200 characters
- `body` (text) - required, minimum 10 characters
- `published` (boolean) - default: false
- Has many comments

### Comment
- `content` (text) - required, minimum 5 characters
- `author` (string) - required
- Belongs to blog
- Can only be added to published blogs

## Routes

```
GET    /blogs
POST   /blogs
GET    /blogs/:id
PATCH  /blogs/:id
DELETE /blogs/:id
PATCH  /blogs/:id/publish
GET    /blogs/:blog_id/comments
POST   /blogs/:blog_id/comments
DELETE /blogs/:blog_id/comments/:id
```

## Project Structure

```
app/
├── controllers/
│   ├── blogs_controller.rb
│   └── comments_controller.rb
├── models/
│   ├── blog.rb
│   └── comment.rb
└── views/
    └── blogs/
config/
└── routes.rb
db/
├── migrate/
└── seeds.rb
```
