json.extract! post, :id, :board_id, :title, :scraped_url, :is_scrap, :status, :response_data, :created_at, :updated_at
json.url post_url(post, format: :json)
