class TripOrganizersController < ApplicationController
  before_action :set_trip_organizer, only: [:destroy, :edit, :show, :update]
  before_action :authenticate_user!
  # GET /trip_organizers
  # GET /trip_organizers.json
  def index
    @trip_organizers = TripOrganizer.all
  end

  # GET /trip_organizers/new
  def new
    @trip_organizer = TripOrganizer.new
  end

  def show
  @tour_reviews = @trip_organizer.tour_reviews.eager_load(:user).paginate(:per_page => 5, :page => params[:page]).order('tour_reviews.created_at DESC')
  end

  def edit

  end
  # POST /trip_organizers
  # POST /trip_organizers.json
  def create
    @trip_organizer = TripOrganizer.new(trip_organizer_params)
    @trip_organizer.user_id = current_user.id
    respond_to do |format|
      if @trip_organizer.save
        current_user.is_trip_organizer = true
        current_user.save
        format.html { redirect_to current_user, notice: 'Trip organizer was successfully created.' }
        format.json { render :show, status: :created, location: @trip_organizer }
      else
        format.html { render :new }
        format.json { render json: @trip_organizer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trip_organizers/1
  # PATCH/PUT /trip_organizers/1.json
  def update
    respond_to do |format|
      if @trip_organizer.update(trip_organizer_params)
        format.html { redirect_to @trip_organizer, notice: 'Trip organizer was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip_organizer }
      else
        format.html { render :edit }
        format.json { render json: @trip_organizer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trip_organizers/1
  # DELETE /trip_organizers/1.json
  def destroy
    @trip_organizer.destroy
    respond_to do |format|
      format.html { redirect_to trip_organizers_url, notice: 'Trip organizer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my_tours
    @tours = Tour.where(trip_organizer_id: params[:trip_organizer_id]).paginate(:per_page => 4, :page => params[:page])
    render 'tours/index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_organizer
      @trip_organizer = TripOrganizer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_organizer_params
      params.require(:trip_organizer).permit(:company_name, :about, :address, :license, :company_email, :company_number, :terms, :company_logo, :url, :cancellation_policy)
    end
end
