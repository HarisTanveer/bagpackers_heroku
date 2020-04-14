class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception
  def new
    @booking = Booking.find params[:id]
    if @booking.payment_status?
      redirect_to my_bookings_path(current_user.id)
    else if @booking.user_id != current_user.id
       redirect_to my_bookings_path(current_user.id)
     end
    end
  end

  def create
    StripeChargesServices.new(charges_params, current_user).call
    @booking = Booking.find params[:id]
    @booking.payment_status = true
    @booking.save

    redirect_to @booking.tour
  end

  private

  def charges_params
    params.permit(:stripeEmail, :stripeToken, :id)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end
end
