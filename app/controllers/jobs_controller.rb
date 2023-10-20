class JobsController < ApplicationController
  before_action :set_post, only: %i[show]
  before_action :prepare_query, only: %i[index], if: :any_filter_present?
  before_action :filter_jobs, only: %i[index]

  def index
    filtered_job_types
    filter_job_specialities
    shift_types
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

  def shift_types
    @shift_types ||= @jobs.scraped.response_data_exist.pluck(Arel.sql("response_data -> 'shift_type'")).compact.map(&:pluralize).uniq
  end

  def related_jobs
    @related_jobs = @job.board.posts.scraped.limit(5)
  end

  def resource_class
    Post
  end

  def filter_jobs
    @jobs = if params[:query].present?
      resource_class.scraped.search(params[:query]).order_by_id.paginate(page: page, per_page: per_page(20))
    else
      resource_class.scraped.order_by_id.paginate(page: page, per_page: per_page(20))
    end
    if @filter_conditions.present?
      where_clause = @filter_conditions.keys.join(' AND ')
      @jobs = @jobs.where(where_clause, *@filter_conditions.values)
    end
  end

  def prepare_query
    @filter_conditions = {}
    filter_params.each do |key, value|
      next if key == "query"
      @filter_conditions["response_data ->> '#{key}' IN (?)"] = value
    end
    @filter_conditions
  end

  def any_filter_present?
    filter_params.present?
  end

  def filter_params
    params.permit(:query, job_type: [], speciality: [], shift_type: [])
  end
end
