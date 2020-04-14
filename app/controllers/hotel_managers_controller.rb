class HotelManagersController < ApplicationController
  before_action :set_hotel_manager, only: [:show, :edit, :update, :destroy]

  # GET /hotel_managers
  # GET /hotel_managers.json
  def index
    @hotel_managers = HotelManager.all
  end

  # GET /hotel_managers/1
  # GET /hotel_managers/1.json
  def show
    # @hotel_manager = @hotel.hotel_manager
    # @hotel_facilities_name = HotelFacilityName.all
    # @hotel_rooms = @hotel.hotel_rooms
    @hotel_reviews = @hotel_manager.hotel_reviews.eager_load(:user).paginate(:per_page => 5, :page => params[:page]).order('hotel_reviews.created_at DESC')
  end

  # GET /hotel_managers/new
  def new
    @hotel_manager = HotelManager.new
  end

  # GET /hotel_managers/1/edit
  def edit
  end

  # POST /hotel_managers
  # POST /hotel_managers.json
  def create
    @hotel_manager = HotelManager.new(hotel_manager_params)
    @hotel_manager.user_id = current_user.id
    respond_to do |format|
      if @hotel_manager.save
        current_user.is_hotel_manager = true
        current_user.save
        format.html { redirect_to @hotel_manager, notice: 'Hotel manager was successfully created.' }
        format.json { render :show, status: :created, location: @hotel_manager }
      else
        format.html { render :new }
        format.json { render json: @hotel_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotel_managers/1
  # PATCH/PUT /hotel_managers/1.json
  def update
    respond_to do |format|
      if @hotel_manager.update(hotel_manager_params)
        format.html { redirect_to @hotel_manager, notice: 'Hotel manager was successfully updated.' }
        format.json { render :show, status: :ok, location: @hotel_manager }
      else
        format.html { render :edit }
        format.json { render json: @hotel_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotel_managers/1
  # DELETE /hotel_managers/1.json
  def destroy
    @hotel_manager.destroy
    respond_to do |format|
      format.html { redirect_to hotel_managers_url, notice: 'Hotel manager was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my_hotels
    @hotels = Hotel.where(hotel_manager_id: params[:hotel_manager_id]).paginate(:per_page => 4, :page => params[:page])
    render 'hotels/index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel_manager
      @hotel_manager = HotelManager.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_manager_params
      params.require(:hotel_manager).permit(:company_name, :proof_of_ownership, :company_logo)
    end
end
