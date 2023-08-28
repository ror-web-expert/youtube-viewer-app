class JobDetail < ApplicationRecord
  belongs_to :job_listing

  enum status: { expire: 0, published: 1, pending: 2 }
end
