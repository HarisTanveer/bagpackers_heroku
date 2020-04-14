class ToursController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tour, only: [:show, :edit, :update, :destroy]
  respond_to  :js

  # GET /tours
  # GET /tours.json
  def index
    @tours = Tour.paginate(:per_page => 12, :page => params[:page])
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
    @trip_organizer = @tour.trip_organizer
    @tour_review  = TourReview.new
    @tour_reviews = @tour.tour_reviews.eager_load(:user).paginate(:per_page => 5, :page => params[:page]).order('tour_reviews.created_at DESC')
  end

  # GET /tours/new
  def new
    @user = User.find current_user.id
    if(!@user.trip_organizer.nil?)
      @tour = Tour.new
    else
      redirect_to root_path
    end
  end

  # GET /tours/1/edit
  def edit
  end

  # POST /tours
  # POST /tours.json
  def create
    @user = User.find current_user.id
    if(!@user.trip_organizer.nil?)
      @tour = Tour.new(tour_params)
      @tour.trip_organizer_id = @user.trip_organizer.id

      respond_to do |format|
        if @tour.save
          @tour_details = []
          @tour.duration.times  do  |index|
            @tour_details[index] = TourDetail.new
            @tour_details[index].day = index
          end

          @tour.tour_details << @tour_details

          format.html { redirect_to @tour, notice: 'Tour was successfully created.' }
          format.json { render :show, status: :created, location: @tour }
        else
          format.html { render :new }
          format.json { render json: @tour.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /tours/1
  # PATCH/PUT /tours/1.json
  def update
    respond_to do |format|
      if @tour.update(tour_params)
        format.html { redirect_to @tour, notice: 'Tour was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }
      else
        format.html { render :edit }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.json
  def destroy
    if @tour.destroy
     render :'tours/success_destroy'
    else
      render :'tours/fail_destroy'
    end
  end

  def add_tour_details

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.eager_load(:tour_details, :tour_reviews).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.require(:tour).permit(:title, :price, :date, :duration, :seats, :tourims_type_id, :description, :services_included, :services_not_included, :locations_id, :image, trip_images: [])
    end
end
