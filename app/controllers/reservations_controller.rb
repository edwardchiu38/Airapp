class ReservationsController < ApplicationController
  
  before_filter :require_login
  before_filter :require_user, :only => [:show, :destroy]  
  
  def require_user
    @reservation = Reservation.find(params[:id])
    if @reservation.user.id != session[:uid]
      redirect_to root_url, notice: "Nice try again!"
    end
  end
  
  # GET /reservations
  # GET /reservations.json
  def index
    @user = User.find(params[:user_id])
    @reservations = @user.reservations

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    @user = User.find(params[:user_id])
    @reservation = @user.reservations.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/new
  # GET /reservations/new.json
  def new
    @reservation = Reservation.new
    @reservation.flight = Flight.find(params[:flight_id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    @reservation = Reservation.find(params[:id])
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(params[:reservation])
    @reservation.user = User.find(session[:uid])
    
    respond_to do |format|
      if @reservation.save
        # email = ReservationMailer.confirm(@reservation)
        # email.deliver
        
        
        # @reservation.flight.seats = @reservation.flight.seats - 1
        # @reservation.flight.save
          
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render json: @reservation, status: :created, location: @reservation }
      else
        format.html { render action: "new" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservations/1
  # PUT /reservations/1.json
  def update
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation = @user.reservations.find(params[:id])
    @reservation.destroy
    flash[:notice] = "Reservation Cancelled."
    
    respond_to do |format|
      format.html { redirect_to user_url(@reservation.user) }
      format.json { head :no_content }
    end
  end
end
