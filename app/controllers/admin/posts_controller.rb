class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[ show edit update destroy scrape_jobs ]

  def index
    @posts = Post.order_by_id.paginate(page: page, per_page: per_page)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def scrape_jobs
    PostScraperJob.perform_async(@post.id)
    redirect_to admin_post_path(@post), notice: 'Post scraping has been initiated.'
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to admin_post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:board_id, :title, :scraped_url, :is_scrap, :status, :response_data)
    end
end
