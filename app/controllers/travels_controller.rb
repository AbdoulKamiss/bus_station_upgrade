class TravelsController < ApplicationController
    before_action :set_travel, only: %i[ show edit update destroy ]

    def index
        @travels = Travel.all
    end

    private
        def set_travel
            @travel = Travel.find(params[:id])
        end
        def travel_params
            params.require(:travel).permit(:starting_station, :destination_station, :date, :time, :duration)
        end
end
