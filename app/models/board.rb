class Board < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :posts, dependent: :destroy

end
