class StripeChargesServices
  DEFAULT_CURRENCY = 'pkr'.freeze

  def initialize(params, user)
    @stripe_email = params[:stripeEmail]
    @stripe_token = params[:stripeToken]
    @booking = params[:id]
    @user = user
  end

  def call
    create_charge(find_customer)
  end

  private

  attr_accessor :user, :stripe_email, :stripe_token, :booking

  def find_customer
    if user.stripe_id
      retrieve_customer(user.stripe_id)
    else
      create_customer
    end
  end

  def retrieve_customer(stripe_token)
    Stripe::Customer.retrieve(stripe_token)
  end

  def create_customer
    customer = Stripe::Customer.create(
        email: stripe_email,
        source: stripe_token
    )
    user.update(stripe_id: customer.id)
    customer
  end

  def create_charge(customer)
    Stripe::Charge.create(
        customer: customer.id,
        amount: order_amount,
        description: customer.email,
        currency: 'pkr'
    )
  end

  def order_amount
    Booking.find_by(id: @booking).payment_amount * 100
  end
end