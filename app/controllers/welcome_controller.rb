class WelcomeController < ApplicationController
    def index
        if user_signed_in?
            u = current_user
            @recommended_tours = u.recommend_tours
            @recommended_tours_by_rating = u.recommend_tours_by_rating
        end
        @tours = Tour.limit(6)
        @locations = Location.limit(6);
        @hotels = Hotel.limit(6)
    end
end
