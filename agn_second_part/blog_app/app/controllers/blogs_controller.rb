require 'benchmark'

class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :published]
  before_action :set_blog, only: %i[ show edit update destroy publish ]
  load_and_authorize_resource except: [:index, :published, :unpublished]

  # gets all the published blogs for showing
  def index
    # benchmark for performance measurement
    benchmark_time = Benchmark.measure do
      @blogs = Blog.published.includes(:user, :comments)
      
      if current_user&.admin?
        @unpublished_blogs = Blog.unpublished.includes(:user)
      elsif current_user
        @unpublished_blogs = Blog.unpublished.includes(:user).where(user_id: current_user.id)
      else
        @unpublished_blogs = []
      end
    end
    
    # log benchmark results for analysis
    Rails.logger.info "Blog Index Benchmark: #{benchmark_time}"
  end

  # shows single blog if its published
  def show
    authorize! :read, @blog
    unless @blog.published? || (current_user && (current_user == @blog.user || current_user.admin?))
      respond_to do |format|
        format.html { redirect_to blogs_path, alert: "Blog is not published yet." }
        format.json { render json: { error: "Blog is not published" }, status: :forbidden }
      end
    end
  end

  # render form for creating new blog
  def new
    @blog = Blog.new
  end

  # render form for editing existing blog
  def edit
  end

  # creates new blog post
  def create
    @blog = current_user.blogs.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to unpublished_blogs_path, notice: "Blog was successfully saved as draft. You can publish it anytime!" }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # updates the blog with new data
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: "Blog was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # deletes the blog from database
  def destroy
    @blog.destroy!

    respond_to do |format|
      format.html { redirect_to blogs_path, notice: "Blog was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # make blog published so evryone can see
  def publish
    service = BlogPublisherService.new(@blog)
    
    if service.call
      respond_to do |format|
        format.html { redirect_to @blog, notice: "Blog was successfully published." }
        format.json { render json: { message: "Blog published successfully", blog: @blog }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to @blog, alert: "Failed to publish blog: #{service.errors.join(', ')}" }
        format.json { render json: { errors: service.errors }, status: :unprocessable_entity }
      end
    end
  end

  # shows only current user's published blogs
  def published
    if current_user
      @blogs = Blog.published.where(user_id: current_user.id).includes(:user, :comments)
    else
      @blogs = []
    end
    render :published
  end

  # shows only current user's unpublished blogs
  def unpublished
    if current_user
      @blogs = Blog.unpublished.where(user_id: current_user.id).includes(:user, :comments)
    else
      @blogs = []
    end
    render :unpublished
  end

  private

  # finds blog by its id
  def set_blog
    @blog = Blog.includes(:user, comments: :user).find_by(id: params[:id])
    unless @blog
      flash[:alert] = "Blog not found"
      redirect_to blogs_path and return
    end
  end

  # only allowing safe params to pass
  def blog_params
    params.expect(blog: [ :title, :body, :published ])
  end
end
