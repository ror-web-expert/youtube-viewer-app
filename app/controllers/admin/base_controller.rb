class Admin::BaseController < ApplicationController
  # before_action :authenticate_user!

  def per_page
    @per_page ||= 15
  end

  def page
    @page ||= params[:page]
  end
end
