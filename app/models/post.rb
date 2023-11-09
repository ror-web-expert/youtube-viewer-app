class Post < ApplicationRecord
  include PgSearch::Model
  extend FriendlyId
  friendly_id :title, use: :slugged
  after_update :check_response_data_change
  belongs_to :board

  enum status: { pending: 'pending', published: 'published',  expire: 'expire' },  _default: :published

  scope :order_by_id, -> { order(id: :desc) }
  scope :scraped, -> { where(is_scrap: true) }
  scope :not_scraped, -> { where(is_scrap: false) }
  scope :response_data_exist, -> { where.not(response_data: nil)}
  scope :speciality_exist, -> { where.not("response_data->>'speciality' IS NULL") }
  scope :job_type_exist, -> { where.not(("response_data->>'job_type' IS NULL")) }
  scope :shift_type_exist, -> { where.not(("response_data->>'shift_type' IS NULL")) }
  scope :remote_type_exist, -> { where.not(("response_data->>'remote_type' IS NULL")) }
  pg_search_scope :search, against: [:title, :response_data],
  using: {
    tsearch: { prefix: true }
  }

  def check_response_data_change
    if saved_change_to_response_data?
      update(is_scrap: true)
    end
  end

  def self.grouped_count(parameter, field)
    public_send(parameter).group("response_data->>'#{field}'").count
  end

  def self.sort_by_count(collection)
    collection.sort_by { |_, count| -count }
  end
end
