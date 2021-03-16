class GigPayment < ApplicationRecord
  belongs_to :gig
  enum state: { pending: 0, complete: 1 }

  def change_state
    gpayments = GigPayment.where(state: 'pending')
    if gpayments.count > 0
      gpayments.each do |gpays|
        gpays.state = 1
        gpays.save
      end
    end
    puts "cron job change_state has finished"
  end
end
