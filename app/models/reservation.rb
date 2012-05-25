class Reservation < ActiveRecord::Base
  attr_accessible :card_number, :flight_id, :travels_on, :user_id
  
  belongs_to :flight
  belongs_to :user
  
  after_create :update_flight
  
  def update_flight
    if flight.seats > 0
      flight.seats -= 1
      flight.save
    end
  end
end
