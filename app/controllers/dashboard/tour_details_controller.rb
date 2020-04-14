class Dashboard::TourDetailsController < ApplicationController
  before_action :set_tour
  before_action :set_tour_detail, only: [:update]

  # GET /tour_details
  # GET /tour_details.json
  def index
    @tour_details = @tour.tour_details
  end

  # PATCH/PUT /tour_details/1
  # PATCH/PUT /tour_details/1.json
  def update
      @tour_detail.update(tour_detail_params)
  end

  private

    def set_tour
      @tour = Tour.find(params[:tour_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_tour_detail
      @tour_detail = @tour.tour_details.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_detail_params
      params.require(:tour_detail).permit(:day, :location, :description)
    end
end
