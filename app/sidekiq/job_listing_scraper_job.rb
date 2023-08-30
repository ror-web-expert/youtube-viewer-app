class JobListingScraperJob
  include Sidekiq::Job

  def perform(job_listing_id)
    job_listing = JobListing.find(job_listing_id)
    scrapper = JobListingScrapperService.new(job_listing)
    scrapper.scrape_and_parse
  end
end
