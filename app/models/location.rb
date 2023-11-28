class Location < ApplicationRecord
  has_many :post, dependent: :nullify
end
