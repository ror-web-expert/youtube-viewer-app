class IndeedAnalyticJob
  include Sidekiq::Job
  sidekiq_options retry: 4

  def perform
    AnalyticScraperService.new.scrape_jobs
  end
end
