class BackfillUserDataToBlogs < ActiveRecord::Migration[8.1]
  def up
    # create system admin user
    admin = User.create!(
      email: 'admin@blog.com',
      password: 'password123',
      password_confirmation: 'password123',
      admin: true,
      name: 'System Admin'
    )

    # assign all existing blogs to admin
    Blog.where(user_id: nil).update_all(user_id: admin.id)
    
    # assign all existing comments to admin
    Comment.where(user_id: nil).update_all(user_id: admin.id)
  end

  def down
    # remove the admin user
    User.find_by(email: 'admin@blog.com')&.destroy
  end
end
