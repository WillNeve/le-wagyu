class BookingsController < ApplicationController
  # new create destroy edit update
  def new
    @booking = Booking.new
    @bbq = Bbq.find(params[:bbq_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @bbq = Bbq.find(params[:bbq_id])
    @user = current_user
    @booking.user = @user
    @booking.bbq = @bbq
    if @booking.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    return unless @booking.user == current_user
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      flash[:success] = "Your booking has been updated!"
      redirect_to bbq_booking_path(current_user)
    else
      render :edit, status: :unprocessable_entite
    end
  end

  def destroy
    ``
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
