class TravelsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin, except: %i[ index show ]
    before_action :set_travel, only: %i[ show edit update destroy ]

    def new
        @travel = Travel.new
    end

    def create
        @travel = Travel.new(travel_params)
        if @travel.save
          flash[:notice] = 'Le voyage a été créer avec succès.'
          redirect_to @travel
        else
          render :new
        end
    end

    def index
        @q = Travel.ransack(params[:q])
        #@travels = @q.result(distinct: true).order(:date).page(params[:page])
        @travels = @q.result(distinct: true).where('date >= ?', Date.today).order(:date).page(params[:page])
        @available_dates = Travel.select(:date).where("date >= ?", Date.today).distinct.order(:date)
    end

    def edit
        @travel = Travel.find(params[:id])
    end

    def update
        @travel = Travel.find(params[:id])
        if @travel.update(travel_params)
          flash[:notice] = 'Le voyage a été modifier avec succès.'
          redirect_to @travel
        else
          render :edit
        end
    end
    
    def destroy
        @travel = Travel.find(params[:id])
        @travel.destroy
        flash[:notice] = 'Le voyage a été annuler avec succès.'
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
              flash[:alert] = "Vous n'êtes pas autoriser à faire cette action."
              redirect_to root_path
            end
        end
end
