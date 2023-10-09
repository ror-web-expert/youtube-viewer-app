class JobsController < ApplicationController
  before_action :set_post, only: %i[show]

  def index
    @jobs = Post.order_by_id.paginate(page: page, per_page: per_page(20))
    filtered_job_types
    filter_job_specialities
    salary_ranges
  end

  def show
    related_jobs
  end

  private

  def set_post
    @job = Post.friendly.find(params[:id])
  end

  def filtered_job_types
    job_type_values = Post.response_data_not_exist.pluck(Arel.sql("response_data -> 'job_type'")).compact.uniq
    desired_job_types = ["PRN (On-call)", "Temporary Full-Time", "Part Time", "Full Time", "PRN"]
    @filtered_job_types = job_type_values.select { |job_type| desired_job_types.include?(job_type) }.uniq
  end

  def filter_job_specialities
    @filter_job_specialities ||= Post.where.not(response_data: nil).pluck(Arel.sql("response_data -> 'speciality'")).compact.uniq.sample(8)
  end

  def salary_ranges
    @salary_ranges ||= ["$20K - $50K", "$50K - $100K", "> $100K", "Other"]
  end

  def related_jobs
    @related_jobs = @job.board.posts.limit(5)
  end
end
