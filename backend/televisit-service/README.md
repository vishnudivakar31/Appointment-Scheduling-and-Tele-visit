# README

## Tele-Visit Mircoservices
This micro-service handles tele-visit session and token creation. This micro-service owns data about appointment tele-visit, uploaded charts and consulation notes

### PORT: 5050

### ENDPOINTS
#### * Create a session for an appointment: 
    GET localhost:5050/televisit?appointment_id=#id&user_token=#token

    ```JSON
    {
        "appointment_id": "#{appointment_id}",
        "session_id": "#{session_id}",
        "patient_token": "#{patient_token}",
        "doctor_token": "#{doctor_token}",
        "started_at": null,
        "ended_at": null,
        "status": 0,
        "created_at": "2020-10-10T21:14:06.469Z",
        "updated_at": "2020-10-10T21:14:06.469Z",
        "consultation_file_path": null
    }
    ```

#### * Get a session for an appointment: 
    GET localhost:5050/televisit/#session_id?user_token=#token

    ```JSON
    {
        "appointment_id": "#{appointment_id}",
        "session_id": "#{session_id}",
        "patient_token": "#{patient_token}",
        "doctor_token": "#{doctor_token}",
        "started_at": null,
        "ended_at": null,
        "status": 0,
        "created_at": "2020-10-10T21:14:06.469Z",
        "updated_at": "2020-10-10T21:14:06.469Z",
        "consultation_file_path": null
    }
    ```

#### * Start a session for an appointment: 
    GET localhost:5050/televisit/#session_id/start?user_token=#token

    ```JSON
    {
        "appointment_id": "#{appointment_id}",
        "session_id": "#{session_id}",
        "patient_token": "#{patient_token}",
        "doctor_token": "#{doctor_token}",
        "started_at": "#{started_datetime}",
        "ended_at": null,
        "status": 1,
        "created_at": "2020-10-10T21:14:06.469Z",
        "updated_at": "2020-10-10T21:14:06.469Z",
        "consultation_file_path": null
    }
    ```

#### * END a session for an appointment: 
    GET localhost:5050/televisit/#session_id/end?user_token=#token

    ```JSON
    {
        "appointment_id": "#{appointment_id}",
        "session_id": "#{session_id}",
        "patient_token": "#{patient_token}",
        "doctor_token": "#{doctor_token}",
        "started_at": "#{started_datetime}",
        "ended_at": "#{ended_datetime}",
        "status": 2,
        "created_at": "2020-10-10T21:14:06.469Z",
        "updated_at": "2020-10-10T21:14:06.469Z",
        "consultation_file_path": null
    }
    ```

#### * Cancel a session for an appointment: 
    DELETE localhost:5050/televisit/#session_id?user_token=#token

    ```JSON
    {
        "appointment_id": "#{appointment_id}",
        "session_id": "#{session_id}",
        "patient_token": "#{patient_token}",
        "doctor_token": "#{doctor_token}",
        "started_at": null,
        "ended_at": null,
        "status": 3,
        "created_at": "2020-10-10T21:14:06.469Z",
        "updated_at": "2020-10-10T21:14:06.469Z",
        "consultation_file_path": null
    }
    ```

### Under Construction
*   Add multiple charts for a session
*   Add consultation notes for a session
*   Find total billing time for a session
