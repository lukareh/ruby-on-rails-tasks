class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_blog
  load_and_authorize_resource

  # get all comments of the blog
  def index
    @comments = @blog.comments
    render json: @comments
  end

  # adds new comment to blog
  def create
    @comment = @blog.comments.build(comment_params)
    @comment.user = current_user if user_signed_in?
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @blog, notice: "Comment was successfully created." }
        format.json { render json: @comment, status: :created }
      else
        format.html { redirect_to @blog, alert: "Failed to create comment: #{@comment.errors.full_messages.join(', ')}" }
        format.json { render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # removes comment from blog
  def destroy
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    
    respond_to do |format|
      format.html { redirect_to @blog, notice: "Comment was successfully deleted." }
      format.json { head :no_content }
    end
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
