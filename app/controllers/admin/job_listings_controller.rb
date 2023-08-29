class Admin::JobListingsController < Admin::BaseController
  before_action :set_job_listing, only: %i[ show edit update destroy scrape_jobs ]

  def index
    @job_listings = JobListing.all
  end

  def show
  end

  def new
    @job_listing = JobListing.new
  end

  def scrape_jobs
    scrapper = ScrapperService.new(@job_listing)
    scrapper.scrape_and_parse

    redirect_to admin_job_listings_path, notice: 'Job detail was successfully scraped and saved.'
  end

  def edit
  end

  def create
    @job_listing = JobListing.new(job_listing_params)

    respond_to do |format|
      if @job_listing.save
        format.html { redirect_to admin_job_listing_url(@job_listing), notice: "Job listing was successfully created." }
        format.json { render :show, status: :created, location: @job_listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_listing.update(job_listing_params)
        format.html { redirect_to admin_job_listing_url(@job_listing), notice: "Job listing was successfully updated." }
        format.json { render :show, status: :ok, location: @job_listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_listing.destroy

    respond_to do |format|
      format.html { redirect_to admin_job_listings_url, notice: "Job listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_job_listing
      @job_listing = JobListing.find(params[:id])
    end

    def job_listing_params
      params.require(:job_listing).permit(:title, :source_url, :listing_selector, :detail_selector)
    end
end
