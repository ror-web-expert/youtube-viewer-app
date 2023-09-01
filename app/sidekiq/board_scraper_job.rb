class BoardScraperJob
  include Sidekiq::Job
  sidekiq_options retry: 4

  def perform(board_id)
    board = Board.find(board_id)
    scrapper = BoardScraperService.new(board)
    scrapper.scrape_and_parse
  end
end
