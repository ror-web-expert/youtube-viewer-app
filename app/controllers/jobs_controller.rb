class JobsController < ApplicationController
  before_action :set_post, :related_jobs, only: %i[show]
  before_action :prepare_query, only: %i[index], if: :any_filter_present?
  before_action :filter_jobs, :filtered_job_types, :filter_job_specialities, :shift_types, only: %i[index]

  def index; end

  def show; end

  private

  def set_post
    @job = resource_class.friendly.find(params[:id])
  end

  def filtered_job_types
    job_type_values = published_jobs.response_data_exist.job_type_exist.group("response_data->>'job_type'").count
    desired_job_types = ["Prn (On Call)", "Temporary Full Time", "Part Time", "Full Time", "PRN"]
    @filtered_job_types = job_type_values.select { |job_type, job_count| desired_job_types.include?(job_type) }.uniq
  end

  def filter_job_specialities
    @filter_job_specialities = published_jobs.response_data_exist.speciality_exist.group("response_data->>'speciality'").count
  end

  def shift_types
    @shift_types = published_jobs.response_data_exist.shift_type_exist.group("response_data->>'shift_type'").count
  end

  def related_jobs
    @related_jobs = @job.board.posts.limit(5)
  end

  def resource_class
    Post
  end

  def filter_jobs
    @jobs = if params[:query].present?
      published_jobs.search(params[:query]).order_by_id.paginate(page: page, per_page: per_page(20))
    else
      published_jobs.order_by_id.paginate(page: page, per_page: per_page(20))
    end
    if @filter_conditions.present?
      where_clause = @filter_conditions.keys.join(' AND ')
      @jobs = @jobs.where(where_clause, *@filter_conditions.values)
    end
  end

  def prepare_query
    @filter_conditions = {}
    filter_params.each do |key, value|
      @filter_conditions["response_data ->> '#{key}' IN (?)"] = value
    end
    @filter_conditions
  end

  def any_filter_present?
    filter_params.present?
  end

  def published_jobs
    resource_class.scraped
  end

  def filter_params
    {
      "job_type" => params[:job_type],
      "speciality" => params[:speciality],
      "shift_type" => params[:shift_type]
    }.compact
  end
end
