class JobsController < ApplicationController
  before_action :set_post, only: %i[show]

  def index
    @jobs = resource_class.scraped.order_by_id.paginate(page: page, per_page: per_page(20))
    filtered_job_types
    filter_job_specialities
    salary_ranges
    locations
  end

  def show
    related_jobs
  end

  private

  def set_post
    @job = resource_class.friendly.find(params[:id])
  end

  def filtered_job_types
    job_type_values = @jobs.scraped.response_data_exist.pluck(Arel.sql("response_data -> 'job_type'")).compact.uniq
    desired_job_types = ["Prn (On Call)", "Temporary Full Time", "Part Time", "Full Time", "PRN"]
    @filtered_job_types = job_type_values.select { |job_type| desired_job_types.include?(job_type) }.uniq
  end

  def filter_job_specialities
    @filter_job_specialities ||= @jobs.scraped.response_data_exist.pluck(Arel.sql("response_data -> 'speciality'")).compact.uniq.sample(8)
  end

  def salary_ranges
    @salary_ranges ||= @jobs.scraped.response_data_exist.pluck(Arel.sql("response_data -> 'salary_range'")).compact.uniq.map{|s| s.tr("a-zA-Z","")}
  end

  def related_jobs
    @related_jobs = @job.board.posts.scraped.limit(5)
  end

  def locations
    @locations = @jobs.scraped.pluck(Arel.sql("response_data -> 'location'")).compact.uniq
  end

  def resource_class
    Post
  end
end
