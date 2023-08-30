class JobDetailScraperJob
  include Sidekiq::Job

  def perform(job_detail_id)
    job_detail = JobDetail.find(job_detail_id)
    scrapper = JobDetailScrapperService.new(job_detail)
    scrapper.scrape_and_parse
  end
end
