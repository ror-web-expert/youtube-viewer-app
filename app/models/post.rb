class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :board

  enum status: { pending: 'pending', published: 'published',  expire: 'expire' },  _default: :pending

  scope :order_by_id, -> { order(id: :desc) }
  scope :scraped, -> { where(is_scrap: true) }
  scope :not_scraped, -> { where(is_scrap: false) }
end
