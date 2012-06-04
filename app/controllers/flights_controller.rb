class FlightsController < ApplicationController
  def index
    @flights = Flight.page(params[:page]).per(4)
  end
end
