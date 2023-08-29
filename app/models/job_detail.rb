class JobDetail < ApplicationRecord
  belongs_to :job_listing

  enum status: { pending: 'pending', published: 'published',  expire: 'expire' },  _default: :pending
end
