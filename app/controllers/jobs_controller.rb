class JobsController < ApplicationController
  before_action :set_post, only: %i[show]

  def index
    @jobs = Post.order_by_id.paginate(page: page, per_page: per_page)
  end

  def show

  end

  private

  def set_post
    @job = Post.find(params[:id])
  end
end
