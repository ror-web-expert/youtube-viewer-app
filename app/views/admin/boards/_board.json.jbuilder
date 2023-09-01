json.extract! board, :id, :title, :source_url, :listing_selector, :detail_selector, :created_at, :updated_at
json.url board_url(board, format: :json)
