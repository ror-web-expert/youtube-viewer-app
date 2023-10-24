class DailyPostsScraperJob
  include Sidekiq::Job
  sidekiq_options queue: 'default', retry: 4

  def perform
    posts = Post.not_scraped
    posts.each do |post|
      scrapper = PostScraperService.new(post)
      scrapper.scrape_and_parse
    end
  end
end
