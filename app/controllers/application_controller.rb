class ApplicationController < ActionController::Base

  def per_page(total = 15)
    @per_page ||= total
  end

  def page
    @page ||= params[:page]
  end
end
