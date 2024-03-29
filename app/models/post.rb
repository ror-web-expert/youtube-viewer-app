class Post < ApplicationRecord
  include PgSearch::Model
  extend FriendlyId
  friendly_id :title, use: :slugged
  after_update :check_response_data_change
  belongs_to :board
  belongs_to :location, optional: true
  before_save :geocode_if_location_changed

  enum status: { pending: 'pending', published: 'published',  expire: 'expire' },  _default: :published
  enum radius: { 0 => 0, 1 => 1, 2 => 2, 5 => 5, 10 => 10, 15 => 15, 20 => 20, 25 => 25, 100 => 100 }
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
    if saved_change_to_response_data? && response_data.present? && response_data['description_raw_html'].present?
      update(is_scrap: true)
    end
  end

  def self.grouped_count(parameter, field)
    public_send(parameter).group("response_data->>'#{field}'").count
  end

  def self.sort_by_count(collection)
    collection.sort_by { |_, count| -count }
  end

  def create_or_attach_location(location)
    return unless location.present?
    result = geocode_address(location)

    if result
      location = Location.find_or_initialize_by(lat: result.first, lng: result.last)
      location.save
      self.location_id = location.id
    end
  end

  def geocode_if_location_changed
    # return unless response_data_changed?
    # changed_attributes["response_data"]["location"] == response_data["location"]

    location = response_data['location']
    create_or_attach_location(location) unless self.location_id.present?
  end

  def geocode_address(address)
    result = Geocoder.search(address, key: Rails.application.credentials.google.geocoding_api_key, params: {countrycodes: "us"}).first
    result&.coordinates
  end
end
