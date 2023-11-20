class JobsController < ApplicationController
  include GeoLocationHelper

  before_action :set_post, :related_jobs, only: %i[show]
  before_action :prepare_query, only: %i[index], if: :any_filter_present?
  before_action :filter_jobs, :filtered_job_types, :filter_job_specialities, :shift_types, :remote_types, only: %i[index]
  before_action :select_jobs_based_on_radius, only: %i[index], if: :radius_params_present?

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
    job_specialities = resource_class.sort_by_count(published_jobs.grouped_count(:speciality_exist, "speciality"))
    display_name_with_total_counts = Hash.new(0)
    job_specialities.each do |key, value|
      matching_keys = Job_Speciality_Filter.select { |_, values| values.include?(key) }.keys
      matching_keys.each { |matching_key| display_name_with_total_counts[matching_key] += value }
    end
    @filter_job_specialities = display_name_with_total_counts
  end

  def shift_types
    @shift_types = resource_class.sort_by_count(published_jobs.grouped_count(:shift_type_exist, "shift_type"))
  end

  def remote_types
    @remote_types = resource_class.sort_by_count(published_jobs.grouped_count(:remote_type_exist, "remote_type"))
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
      if key == "speciality"
        value  = value.map{|val| Job_Speciality_Filter[val]}.flatten
        @filter_conditions["response_data ->> '#{key}' IN (?)"] = value
      else
        @filter_conditions["response_data ->> '#{key}' IN (?)"] = value
      end
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
      "shift_type" => params[:shift_type],
      "remote_type" => params[:remote_type]
    }.compact
  end

  def radius_params_present?
    radius.present?
  end

  def select_jobs_based_on_radius
    user_location = initialize_geocoder
    user_lat = user_location.first
    user_lng = user_location.last
    @jobs = @jobs.select do |job|
      loc = job.location
      if loc.present?
        haversine(user_lat, user_lng, loc&.lat, loc&.lng) <= radius.to_i
      else
        next
      end
    end
  end

  def radius
    params[:radius]
  end
end
