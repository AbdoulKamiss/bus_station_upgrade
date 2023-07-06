class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings
  end

  def new
      @booking = Booking.new
      @travel = Travel.find(params[:travel_id])
      @user = User.find_by(id: current_user.id)
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      UserBooking.create(user_id: current_user.id, booking_id: @booking.id)
      flash[:notice] = "Travel successfully booked!"
      redirect_to booking_path(@booking.confirmation)
    else
      @travel = Travel.find(params[:booking][:travel_id])
      render :new
    end
  end

  def show
    @booking = Booking.find_by(confirmation: params[:id])
    if @booking
      render :show
    else
      flash[:alert] = 'Sorry, the booking you\'re looking for does not exist.'
      redirect_to root_url
    end
  end

  def destroy
    @booking = Booking.find_by(confirmation: params[:id])
    @booking.destroy
    flash[:notice] = 'Booking was successfully canceled.'
    redirect_to bookings_url
  end

  private

  def booking_params
    params.require(:booking).permit(:travel_id)
  end
end