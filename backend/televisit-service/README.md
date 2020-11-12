# README

## Tele-Visit Mircoservices
This micro-service handles tele-visit session and token creation. This micro-service owns data about appointment tele-visit, uploaded charts and consulation notes

### Heroku URL: https://televisit-service.herokuapp.com

### PORT: 5050

### ENDPOINTS
#### * Create a session for an appointment: 
    POST localhost:5050/televisit?user_token=#token

##### * Request Body

```JSON
{
    "appointment_id": "#{appointment_id}"
}
```

##### * Response (Status: 201 Created)

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
    "updated_at": "2020-10-10T21:14:06.469Z"
}
```

#### * Get a session for an appointment: 
    GET localhost:5050/televisit/#session_id?user_token=#token

##### * Response (Status: 200 OK)

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
    "updated_at": "2020-10-10T21:14:06.469Z"
}
```

#### * Start a session for an appointment: 
    GET localhost:5050/televisit/#session_id/start?user_token=#token

##### * Response (Status: 200 OK)
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
    "updated_at": "2020-10-10T21:14:06.469Z"
}
```

#### * END a session for an appointment: 
    GET localhost:5050/televisit/#session_id/end?user_token=#token

##### * Response (Status: 200 OK)
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
    "updated_at": "2020-10-10T21:14:06.469Z"
}
```

#### * Cancel a session for an appointment: 
    DELETE localhost:5050/televisit/#session_id?user_token=#token


##### * Response (Status: 200 OK)
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
    "updated_at": "2020-10-10T21:14:06.469Z"
}
```

#### * Get billing time for tele-visit: 
    GET localhost:5050/televisit/#session_id/billing_time?user_token=#token

##### * Response (Status: 200 OK)
```JSON
{
    "billing_time": 1393,
    "appointment_id": "#{appointment_id}",
    "started_at": "2020-10-10T20:59:59.644Z",
    "ended_at": "2020-10-10T21:23:12.209Z",
    "time_unit": "seconds"
}
```
```
Billing Time Constraints
1. Bill Generation Constraints:
    i)   Tele-Visit should be in ENDED state
2. Bill Generation Failure Constraints:
    i)   Tele-Visit is pending
    ii)  Tele-Visit is active
    iii) Tele-Visit is cancelled.
```
### Under Construction
*   User authorization for CRUD tele-visit
