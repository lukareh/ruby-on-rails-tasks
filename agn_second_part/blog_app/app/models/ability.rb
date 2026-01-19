# frozen_string_literal: true

# defines user permissions for resources
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      # admin can do everything
      can :manage, :all
    else
      # regular users can read all published blogs
      can :read, Blog, published: true
      
      # users can manage their own blogs
      can :manage, Blog, user_id: user.id
      
      # users can only see published blogs or their own unpublished blogs
      can :read, Blog do |blog|
        blog.published? || blog.user_id == user.id
      end
      
      # users can create comments on published blogs
      can :create, Comment
      
      # users can update/delete their own comments
      can [:update, :destroy], Comment, user_id: user.id
      
      # users can delete comments on their own blog posts
      can :destroy, Comment do |comment|
        comment.blog.user_id == user.id
      end
      
      # users can manage their own profile
      can :manage, User, id: user.id
    end
  end
end
