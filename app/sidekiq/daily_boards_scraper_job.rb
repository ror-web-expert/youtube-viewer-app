class DailyBoardsScraperJob
  include Sidekiq::Job
  sidekiq_options queue: 'default', retry: 4

  def perform
    boards = Board.all
    boards.each do |board|
      scrapper = BoardScraperService.new(board)
      scrapper.scrape_and_parse
    end
  end
end
