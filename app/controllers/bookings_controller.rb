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
      flash.notice = "Travel successfully booked! A confirmation email has been sent to each passenger."
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

#  def search
#  if params.has_key?(:button)
#      if !params.has_key?(:search_field)
#        flash.alert = 'You must select to search by Confirmation Number or Email Address.'
#        redirect_to search_bookings_url
#      elsif params[:search_field] == 'confirmation'
#        @booking = Booking.find_by(confirmation: params[:search_param].upcase)
#        if @booking
#          redirect_to booking_url(@booking.confirmation)
#        else
#          flash.alert = 'No booking could be found with the given parameters.'
#          redirect_to search_bookings_url
#        end
#      else
#        @bookings = Booking.includes(:passengers, flight: [:origin, :destination])
#                           .where('passengers.email ILIKE ?', params[:search_param])
#                           .references(:passengers)
#                           .order(:date, :time)
#        @email = params[:search_param]
#        flash.alert = 'No booking could be found with the given parameters.' if @bookings.empty?
#        render :search
#      end
#    else
#      render :search
#    end
#  end

#  def index
#    redirect_to search_bookings_url
#  end

  private

  def booking_params
    params.require(:booking).permit(:travel_id)
  end
end