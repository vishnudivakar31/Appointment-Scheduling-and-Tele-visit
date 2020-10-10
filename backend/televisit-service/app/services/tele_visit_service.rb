require 'opentok'
class TeleVisitService

    def initialize(api_key, api_secret)
        @opentok = OpenTok::OpenTok.new api_key, api_secret
    end
    
    module VISIT_STATUS
        PENDING = 0
        ENDED = 1
        CANCELLED = 2
    end

    def create_visit(id)
        session_id = get_session_id
        patient_token = get_token session_id
        doctor_token = get_token session_id
        visit = TeleVisit.create(appointment_id: id, session_id: session_id, patient_token: patient_token, doctor_token: doctor_token, status: VISIT_STATUS::PENDING)
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