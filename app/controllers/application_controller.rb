class ApplicationController < ActionController::Base

  def per_page
    @per_page ||= 15
  end

  def page
    @page ||= params[:page]
  end
end
