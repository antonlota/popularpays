class GigPayment < ApplicationRecord
  belongs_to :gig
  enum state: { pending: 0, complete: 1 }
end
