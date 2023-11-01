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
    @filtered_job_types = resource_class.sort_by_count(published_jobs.grouped_count(:job_type_exist, "job_type"))
  end

  def filter_job_specialities
    @filter_job_specialities = resource_class.sort_by_count(published_jobs.grouped_count(:speciality_exist, "speciality"))
  end

  def shift_types
    @shift_types = resource_class.sort_by_count(published_jobs.grouped_count(:shift_type_exist, "shift_type"))
  end

  def related_jobs
    @related_jobs = if @job.response_data["speciality"].present?
      @job.board.posts.where("response_data ->> 'speciality' = ?", @job.response_data["speciality"]).limit(5)
    else
      @job.board.posts.sample(5)
    end
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
    resource_class.scraped.response_data_exist
  end

  def filter_params
    {
      "job_type" => params[:job_type],
      "speciality" => params[:speciality],
      "shift_type" => params[:shift_type]
    }.compact
  end
end
