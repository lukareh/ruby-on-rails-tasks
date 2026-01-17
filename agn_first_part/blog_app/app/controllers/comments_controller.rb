class CommentsController < ApplicationController
  before_action :set_blog

  # get all comments of the blog
  def index
    @comments = @blog.comments
    render json: @comments
  end

  # adds new comment to blog
  def create
    @comment = @blog.comments.build(comment_params)
    
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # removes comment from blog
  def destroy
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    head :no_content
  end

  private

  # finds the blog using id from url
  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

  # allowing only safe parameters for comment
  def comment_params
    params.require(:comment).permit(:content, :author)
  end
end
