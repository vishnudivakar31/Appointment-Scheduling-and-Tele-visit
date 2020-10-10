# README

## Tele-Visit Mircoservices
This micro-service handles tele-visit session and token creation. This micro-service owns data about appointment tele-visit, uploaded charts and consulation notes

### PORT: 5050

### ENDPOINTS
#### * Create a session for an appointment: 
    GET localhost:5050/televisit?appointment_id=#id&user_token=#token

#### * Get a session for an appointment: 
    GET localhost:5050/televisit/#session_id?user_token=#token

#### * Start a session for an appointment: 
    GET localhost:5050/televisit/#session_id/start?user_token=#token

#### * END a session for an appointment: 
    GET localhost:5050/televisit/#session_id/end?user_token=#token

#### * Cancel a session for an appointment: 
    DELETE localhost:5050/televisit/#session_id?user_token=#token

### Under Construction
*   Add multiple charts for a session
*   Add consultation notes for a session
*   Find total billing time for a session
