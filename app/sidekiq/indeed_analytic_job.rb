class IndeedAnalyticJob
  include Sidekiq::Job
  sidekiq_options queue: 'default', retry: 3

  def perform
    AnalyticScraperService.new.scrape_jobs
  end
end
