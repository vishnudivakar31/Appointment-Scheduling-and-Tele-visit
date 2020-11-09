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
        session = generate_session
        session_id = get_session_id session
        patient_token = get_token session
        doctor_token = get_token session
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
        if visit && visit.status != VISIT_STATUS::ENDED
            visit.status = VISIT_STATUS::CANCELLED
            visit.save
        end
        visit
    end

    def billing_time(id)
        visit = TeleVisit.find(id)
        if visit && visit.status != VISIT_STATUS::CANCELLED && visit.status === VISIT_STATUS::ENDED
            bt = visit.ended_at.to_time.to_i - visit.started_at.to_time.to_i
            response = {billing_time: bt, appointment_id: visit.appointment_id, started_at: visit.started_at, ended_at: visit.ended_at, time_unit: 'seconds'}
            return response
        end
        return nil
    end

    def get_televisit_by_appointment_id(appointment_id)
        visit = TeleVisit.find_by(appointment_id: appointment_id)
        if visit && visit.status != VISIT_STATUS::CANCELLED
            return visit
        end
        return nil
    end

    private

    def get_session_id(session)
        session.session_id
    end

    def generate_session
        @opentok.create_session
    end

    def get_token(session)
        session.generate_token({
            :expire_time => Time.now + 30.day
        })
    end

end