class GigSerializer < ActiveModel::Serializer
  attributes :id, :brand_name, :creator_id
  
  belongs_to :creator
  has_one :gig_payment
end
