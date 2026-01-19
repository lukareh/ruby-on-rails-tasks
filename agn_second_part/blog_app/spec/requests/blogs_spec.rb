require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  describe "GET /blogs" do
    let!(:published_blog1) { create(:blog, :published, title: "Published Blog 1", user: user) }
    let!(:published_blog2) { create(:blog, :published, title: "Published Blog 2", user: user) }
    let!(:unpublished_blog) { create(:blog, :unpublished, title: "Unpublished Blog", user: user) }

    it "returns http success" do
      get blogs_path
      expect(response).to have_http_status(:success)
    end

    it "shows published blogs in the body" do
      get blogs_path
      expect(response.body).to include(published_blog1.title)
      expect(response.body).to include(published_blog2.title)
    end
  end

  describe "GET /blogs/:id" do
    context "when blog is published" do
      let(:blog) { create(:blog, :published, user: user) }

      it "returns http success" do
        get blog_path(blog)
        expect(response).to have_http_status(:success)
      end

      it "shows the blog content" do
        get blog_path(blog)
        expect(response.body).to include(blog.title)
      end
    end

    context "when blog is not published and user is not logged in" do
      let(:blog) { create(:blog, :unpublished, user: user) }

      it "redirects due to authorization" do
        get blog_path(blog)
        expect(response).to have_http_status(:redirect)
      end
    end

    context "when blog is not published and user is the owner" do
      let(:blog) { create(:blog, :unpublished, user: user) }

      it "allows owner to view" do
        sign_in user
        get blog_path(blog)
        expect(response).to have_http_status(:success)
      end
    end

    context "when blog is not published and user is admin" do
      let(:blog) { create(:blog, :unpublished, user: user) }

      it "allows admin to view" do
        sign_in admin
        get blog_path(blog)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
