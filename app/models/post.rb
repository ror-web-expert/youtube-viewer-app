class Post < ApplicationRecord
  include PgSearch::Model
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :board

  enum status: { pending: 'pending', published: 'published',  expire: 'expire' },  _default: :published

  scope :order_by_id, -> { order(id: :desc) }
  scope :scraped, -> { where(is_scrap: true) }
  scope :not_scraped, -> { where(is_scrap: false) }
  scope :response_data_exist, -> { where.not(response_data: nil)}
  scope :speciality_exist, -> { where.not("response_data->>'speciality' IS NULL") }
  scope :job_type_exist, -> { where.not(("response_data->>'job_type' IS NULL")) }
  scope :shift_type_exist, -> { where.not(("response_data->>'shift_type' IS NULL")) }
  pg_search_scope :search, against: [:title, :response_data],
  using: {
    tsearch: { prefix: true }
  }
end
