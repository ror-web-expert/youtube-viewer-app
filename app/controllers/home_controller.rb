class HomeController < ApplicationController
  def index
    @posts = Post.paginate(page: page, per_page: per_page)
  end
end
