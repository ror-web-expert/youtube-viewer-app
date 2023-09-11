class HomeController < ApplicationController
  def index
    @posts = Post.order_by_id.paginate(page: page, per_page: per_page)
  end
end
