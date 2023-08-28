json.extract! job_detail, :id, :job_listing_id, :title, :scraped_url, :is_scrap, :status, :response_data, :created_at, :updated_at
json.url job_detail_url(job_detail, format: :json)
