class JobsController < ApplicationController
  before_action :set_post, only: %i[show]

  def index
    @jobs = Post.order_by_id.paginate(page: page, per_page: per_page(20))
  end

  def show

  end

  private

  def set_post
    @job = Post.friendly.find(params[:id])
  end
end
