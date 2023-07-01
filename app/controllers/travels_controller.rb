class TravelsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :set_travel, only: %i[ show edit update destroy ]

    def index
       # @travels = Travel.all.page(params[:page])
        @q = Travel.ransack(params[:q])
        @travels = @q.result(distinct: true).page(params[:page])
    end

    private
        def set_travel
            @travel = Travel.find(params[:id])
        end
        def travel_params
            params.require(:travel).permit(:starting_station, :destination_station, :date, :time, :duration)
        end
end
