class Admin::JobAnalyticsController < ApplicationController

  def index

  end

  def scrape_jobs
    IndeedAnalyticJob.perform_async
    redirect_to admin_job_analytics_path, notice: 'Job scraping completed and CSV downloaded!'
  end

  def download
    file_path = Rails.root.join('public', 'job_analytics.csv')

    if File.exist?(file_path)
      send_file file_path, type: 'text/csv', disposition: 'attachment'
    else
      flash[:alert] = 'File not found'
      redirect_to root_path
    end
  end
end
