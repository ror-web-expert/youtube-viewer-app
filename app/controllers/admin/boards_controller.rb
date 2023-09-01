class Admin::BoardsController < Admin::BaseController
  before_action :set_board, only: %i[ show edit update destroy scrape_jobs ]

  def index
    @boards = Board.all
  end

  def show
  end

  def new
    @board = Board.new
  end

  def scrape_jobs
    # BoardScraperJob.perform_async(@board.id)
    scrapper = BoardScraperService.new(@board)
    scrapper.scrape_and_parse

    redirect_to admin_boards_path, notice: 'Board scraping has been initiated.'

  end

  def edit
  end

  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to admin_board_url(@board), notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to admin_board_url(@board), notice: "Board was successfully updated." }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @board.destroy

    respond_to do |format|
      format.html { redirect_to admin_boards_url, notice: "Board was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_board
      @board = Board.find(params[:id])
    end

    def board_params
      params.require(:board).permit(:title, :source_url, :listing_selector, :detail_selector)
    end
end
