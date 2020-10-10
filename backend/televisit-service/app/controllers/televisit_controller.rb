class TelevisitController < ApplicationController
    def initialize
        api_key = Rails.application.config.opentok_api_key
        secret_key = Rails.application.config.opentok_secret_key
        @teleVisitService = TeleVisitService.new api_key, secret_key
    end
    
    def create
        visit = @teleVisitService.create_visit(params[:appointment_id])
        if visit.errors.full_messages.length === 0
            render json: visit, status: 201
        else
            render json: {message: visit.errors.full_messages}, status: 500
        end
    end
    
    def show
        # TODO: Show Televisit
    end

    def start
        # TODO: end a televisit
    end

    def end
        # TODO: end a televisit
    end

    def add_charts
        # TODO: add bulk charts to a file
    end

    def add_consulation_notes
        # TODO: make a file for consulation notes and attach with meeting
    end

    def destroy
        # TODO: Cancel the televisit
    end
end