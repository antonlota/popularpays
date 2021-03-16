class Gig < ApplicationRecord
  belongs_to :creator
  has_one :gig_payment
  enum state: { applied: 0, accepted: 1, completed: 2, paid: 3}
end
