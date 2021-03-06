class Reservation < ActiveRecord::Base
  attr_accessible :card_number, :flight_id, :travels_on, :user_id
  
  belongs_to :flight
  belongs_to :user
  
  after_create :update_flight
  after_create :update_miles
  after_create :send_confirmation_email
  
  def send_confirmation_email
    email = ReservationMailer.confirm(self)
    email.deliver
  end
  
  after_destroy :handle_cancellation
  
  def handle_cancellation
    user.miles -= flight.distance
    user.save
    flight.seats += 1
    flight.save
  end
  
  def update_miles
    user.miles += flight.distance
    user.save
  end
  
  def update_flight
    if flight.seats > 0
      flight.seats -= 1
      # if flight.save == false
      #   raise ActiveRecord::Rollback
      # end
    end
  end
end
