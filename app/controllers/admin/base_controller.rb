class Admin::BaseController < ApplicationController
  # before_action :authenticate_user!

  def per_page
    @per_page ||= 50
  end

  def page
    @page ||= params[:page]
  end
end
