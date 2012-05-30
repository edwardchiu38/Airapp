class FlightsController < ApplicationController
  def index
    @flights = Flight.limit(1000)
  end
end
