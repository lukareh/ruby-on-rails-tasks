class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy publish ]

  # gets all the published blogs for showing
  def index
    @blogs = Blog.published
    @unpublished_blogs = Blog.unpublished
  end

  # shows single blog if its published
  def show
    unless @blog.published?
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
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: "Blog was successfully created." }
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
    if @blog.update(published: true)
      respond_to do |format|
        format.html { redirect_to @blog, notice: "Blog was successfully published." }
        format.json { render json: { message: "Blog published successfully", blog: @blog }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to @blog, alert: "Failed to publish blog." }
        format.json { render json: { errors: @blog.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  # finds blog by its id
  def set_blog
    @blog = Blog.find_by(id: params[:id])
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
