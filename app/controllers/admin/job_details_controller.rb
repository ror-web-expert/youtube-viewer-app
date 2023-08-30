class Admin::JobDetailsController < Admin::BaseController
  before_action :set_job_detail, only: %i[ show edit update destroy scrape_jobs ]

  def index
    @job_details = JobDetail.all
  end

  def show
  end

  def new
    @job_detail = JobDetail.new
  end

  def edit
  end

  def scrape_jobs
    job_detail = JobDetail.find(params[:id])
    JobDetailScraperJob.perform_async(job_detail.id)

    redirect_to admin_job_detail_path(job_detail), notice: 'Job detail scraping has been initiated.'
  end

  def create
    @job_detail = JobDetail.new(job_detail_params)

    respond_to do |format|
      if @job_detail.save
        format.html { redirect_to admin_job_detail_url(@job_detail), notice: "Job detail was successfully created." }
        format.json { render :show, status: :created, location: @job_detail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_detail.update(job_detail_params)
        format.html { redirect_to admin_job_detail_url(@job_detail), notice: "Job detail was successfully updated." }
        format.json { render :show, status: :ok, location: @job_detail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_detail.destroy

    respond_to do |format|
      format.html { redirect_to admin_job_details_url, notice: "Job detail was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_job_detail
      @job_detail = JobDetail.find(params[:id])
    end

    def job_detail_params
      params.require(:job_detail).permit(:job_listing_id, :title, :scraped_url, :is_scrap, :status, :response_data)
    end
end
