class TelevisitController < ApplicationController
    def initialize
        logger.debug 'Tele-Visit Controller initiated'
        api_key = Rails.application.config.opentok_api_key
        secret_key = Rails.application.config.opentok_secret_key
        @teleVisitService = TeleVisitService.new api_key, secret_key
        logger.debug 'Tele-Visit Service initiated'
    end

    def index
        appointment_id = params[:appointment_id]
        if appointment_id
            visit = @teleVisitService.get_televisit_by_appointment_id(appointment_id)
            if visit
                logger.debug 'televisit fetched'
                render json: visit, status: 200
            else
                logger.fatal "error: no visit found with appointment id #{appointment_id}"
                render json: {message: "error: no visit found with appointment id #{appointment_id}"}, status: 500
            end
        else
            render json: {message: 'appointment id is expected with this API'}, status: 500
        end
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
        visit = @teleVisitService.show_visit(params[:id])
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

    def billing_time
        billing_time_json = @teleVisitService.billing_time(params[:id])
        if billing_time_json
            logger.debug 'tele-visit billing time generated'
            render json: billing_time_json, status: 200
        else
            logger.fatal "tele-visit: unable to generate billing time"
            render json: {message: "unable to generate billing time. probable reasons: no tele-visit record, requesting billing time for an active session or requesting billing time for a cancelled session"}, status: 500
        end
    end
end