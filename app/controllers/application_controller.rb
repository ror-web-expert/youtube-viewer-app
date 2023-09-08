class ApplicationController < ActionController::Base

    def per_page
        @per_page ||= 50
      end
    
      def page
        @page ||= params[:page]
      end
end
