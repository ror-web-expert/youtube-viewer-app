class Post < ApplicationRecord
  belongs_to :board

  enum status: { pending: 'pending', published: 'published',  expire: 'expire' },  _default: :pending
end
