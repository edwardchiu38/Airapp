class Reservation < ActiveRecord::Base
  attr_accessible :card_number, :flight_id, :travels_on, :user_id
  
  belongs_to :flight
  belongs_to :user
  
  after_create :update_flight
  after_create :update_miles
  
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
