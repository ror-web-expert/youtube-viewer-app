class PostScraperJob
  include Sidekiq::Job
  sidekiq_options retry: 4

  def perform(post_id)
    post = Post.find(post_id)
    scrapper = PostScraperService.new(post)
    scrapper.scrape_and_parse
  end
end
