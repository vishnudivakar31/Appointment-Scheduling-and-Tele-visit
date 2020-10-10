require 'opentok'
class TeleVisitService

    def initialize(api_key, api_secret)
        @opentok = OpenTok::OpenTok.new api_key, api_secret
    end
    
    module VISIT_STATUS
        PENDING = 0
        ACTIVE = 1
        ENDED = 2
        CANCELLED = 3
    end

    def create_visit(id)
        session_id = get_session_id
        patient_token = get_token session_id
        doctor_token = get_token session_id
        visit = TeleVisit.create(appointment_id: id, session_id: session_id, patient_token: patient_token, doctor_token: doctor_token, status: VISIT_STATUS::PENDING)
        visit
    end

    def show_visit(id)
        visit = TeleVisit.find(id)
        return visit && visit.status != VISIT_STATUS::CANCELLED ? visit : nil
    end

    def start_session(id)
        visit = TeleVisit.find(id)
        if visit && visit.status != VISIT_STATUS::CANCELLED && visit.status != VISIT_STATUS::ENDED
            visit.started_at = Time.now
            visit.status = VISIT_STATUS::ACTIVE
            visit.save
        end
        visit
    end

    def end_session(id)
        visit = TeleVisit.find(id)
        if visit && visit.status != VISIT_STATUS::CANCELLED && visit.status != VISIT_STATUS::ENDED && visit.status === VISIT_STATUS::ACTIVE
            visit.ended_at = Time.now
            visit.status = VISIT_STATUS::ENDED
            visit.save
        end
        visit
    end

    def cancel_session(id)
        visit = TeleVisit.find(id)
        if visit 
            visit.status = VISIT_STATUS::CANCELLED
            visit.save
        end
        visit
    end

    private

    def get_session_id
        @opentok.create_session.session_id
    end

    def get_token(session_id)
        @opentok.generate_token session_id
    end

end