class TelevisitController < ApplicationController
    def initialize
        logger.debug 'Tele-Visit Controller initiated'
        api_key = Rails.application.config.opentok_api_key
        secret_key = Rails.application.config.opentok_secret_key
        @teleVisitService = TeleVisitService.new api_key, secret_key
        logger.debug 'Tele-Visit Service initiated'
    end
    
    def create
        visit = @teleVisitService.create_visit(params[:appointment_id])
        if visit.errors.full_messages.length === 0
            logger.debug 'new tele-visit created'
            render json: visit, status: 201
        else
            logger.fatal "error: #{visit.errors.full_messages}"
            render json: {message: visit.errors.full_messages}, status: 500
        end
    end
    
    def show
        visit = TeleVisit.find(params[:id])
        if visit
            logger.debug 'show tele-visit successful'
            render json: visit, status: 200
        else
            logger.fatal "error: invalid tele-visit id: #{params[:id]}"
            render json: {message: "invalid tele-visit id: #{params[:id]}"}, status: 404
        end
    end

    def start
        visit = @teleVisitService.start_session(params[:id])
        if visit && visit.errors.full_messages.length === 0
            logger.debug 'tele-visit started'
            render json: visit, status: 200
        elsif visit && visit.errors.full_messages.length > 0
            logger.fatal "error: #{visit.errors.full_messages.length}"
            render json: {message: visit.errors.full_messages.length}, status: 500
        else
            logger.fatal "error: invalid tele-visit id: #{params[:id]}"
            render json: {message: "invalid tele-visit id: #{params[:id]}"}, status: 404
        end
    end

    def end
        visit = @teleVisitService.end_session(params[:id])
        if visit && visit.errors.full_messages.length === 0
            logger.debug 'tele-visit ended'
            render json: visit, status: 200
        elsif visit && visit.errors.full_messages.length > 0
            logger.fatal "error: #{visit.errors.full_messages.length}"
            render json: {message: visit.errors.full_messages.length}, status: 500
        else
            logger.fatal "error: invalid tele-visit id: #{params[:id]}"
            render json: {message: "invalid tele-visit id: #{params[:id]}"}, status: 404
        end
    end

    def add_charts
        # TODO: add bulk charts to a file
    end

    def add_consulation_notes
        # TODO: make a file for consulation notes and attach with meeting
    end

    def destroy
        visit = @teleVisitService.cancel_session(params[:id])
        if visit && visit.errors.full_messages.length === 0
            logger.debug 'tele-visit cancelled'
            render json: visit, status: 200
        elsif visit && visit.errors.full_messages.length > 0
            logger.fatal "error: #{visit.errors.full_messages.length}"
            render json: {message: visit.errors.full_messages.length}, status: 500
        else
            logger.fatal "error: invalid tele-visit id: #{params[:id]}"
            render json: {message: "invalid tele-visit id: #{params[:id]}"}, status: 404
        end
    end
end