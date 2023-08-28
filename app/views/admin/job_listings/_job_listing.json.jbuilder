json.extract! job_listing, :id, :title, :source_url, :is_scrap, :listing_selector, :detail_selector, :created_at, :updated_at
json.url job_listing_url(job_listing, format: :json)
