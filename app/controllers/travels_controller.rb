class TravelsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin, except: %i[ index]
    before_action :set_travel, only: %i[ show edit update destroy ]

    def new
        @travel = Travel.new
    end

    def create
        @travel = Travel.new(travel_params)
        if @travel.save
          flash[:notice] = 'Travel was successfully created.'
          redirect_to @travel
        else
          render :new
        end
    end

    def index
        @q = Travel.ransack(params[:q])
        @travels = @q.result(distinct: true).page(params[:page])
    end

    def edit
        @travel = Travel.find(params[:id])
    end

    def update
        @travel = Travel.find(params[:id])
        if @travel.update(travel_params)
          flash[:notice] = 'Travel was successfully updated.'
          redirect_to @travel
        else
          render :edit
        end
    end
    
    def destroy
        @travel = Travel.find(params[:id])
        @travel.destroy
        flash[:notice] = 'Travel was successfully destroyed.'
        redirect_to root_path
    end
      

    private
        def set_travel
            @travel = Travel.find(params[:id])
        end
        def travel_params
            params.require(:travel).permit(:starting_station_id, :destination_station_id, :date, :time, :duration)
        end
        def authorize_admin
            unless current_user.admin?
              flash[:alert] = "You are not authorized to perform this action."
              redirect_to root_path
            end
        end
end
