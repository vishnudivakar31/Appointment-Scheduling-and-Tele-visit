# README

## Appointment Mircoservices
This micro-service handles scheduling appointment, updating appointment, post charts, download charts, post consultation summary and download consultation summary.

### PORT: 4040

### ENDPOINTS
#### * Create an appointment: 
    POST localhost:4040/appointment?tele_visit=true&user_token=#token

##### Request Body
```JSON
{
    "patient_id": "#patient_id",
    "doctor_id": "#doctor_id",
    "start_time": "#start_time",
    "end_time": "#end_time"
}
```

##### Constraints
```
tele_visit = true/false; true for tele-visit enabled appointments and false for in-person appointments
end_time > start_time
start_time, end_time : Format 'YYYY-MM-DDTHH-mm'
```

##### Response (Status: 201 Created)
```JSON
{
    "appointment_id": "#appointment_id",
    "patient_id": "#patient_id",
    "start_time": "#start_time",
    "end_time": "#end_time",
    "doctor_id": "#doctor_id",
    "appointment_status": "#status",
    "created_at": "2020-10-20T23:43:22.496Z",
    "updated_at": "2020-10-20T23:43:22.496Z"
}
```

#### * Get an appointment by ID: 
    GET localhost:4040/appointment/#id?user_token=#token

##### Response (Status: 200 Ok)
```JSON
{
    "appointment_id": "#appointment_id",
    "patient_id": "#patient_id",
    "start_time": "#start_time",
    "end_time": "#end_time",
    "doctor_id": "#doctor_id",
    "appointment_status": "#status",
    "created_at": "2020-10-20T23:43:22.496Z",
    "updated_at": "2020-10-20T23:43:22.496Z"
}
```

#### * Update appointment status: 
    PUT/PATCH localhost:4040/appointment/#id?user_token=#token&appointment_status=#status

##### Response (Status: 200 Ok)
```JSON
{
    "appointment_id": "#appointment_id",
    "patient_id": "#patient_id",
    "start_time": "#start_time",
    "end_time": "#end_time",
    "doctor_id": "#doctor_id",
    "appointment_status": 0,
    "created_at": "2020-10-20T23:43:22.496Z",
    "updated_at": "2020-10-20T23:43:22.496Z"
}
```
##### Constraints
```
Appointment Status
------------------
PENDING = 0
ACTIVE = 1
ENDED = 2
CANCELLED = 3
```

#### * Upload charts for appointment (bulk is enabled):
    POST localhost:4040/appointment/#id/charts?user_token=#token

##### Request Body
```
type_of_body: form-data
form-data should have following attributes
----------
key: value
----------
files_count: number_of_files_uploaded
file#: file_data

file# : # starts from 1..files_count
```
##### Response (Status: 200 Ok)
```JSON
[
    {
        "id": "#chart_id",
        "file_path": "#chart_loc",
        "created_at": "2020-10-20T23:57:23.340Z",
        "updated_at": "2020-10-20T23:57:23.340Z",
        "appointment_id": "#appointment_id"
    },
    {
        "id": "#chart_id",
        "file_path": "#chart_loc",
        "created_at": "2020-10-20T23:57:23.364Z",
        "updated_at": "2020-10-20T23:57:23.364Z",
        "appointment_id": "#appointment_id"
    },
    {
        "id": "#chart_id",
        "file_path": "#chart_loc",
        "created_at": "2020-10-20T23:57:23.374Z",
        "updated_at": "2020-10-20T23:57:23.374Z",
        "appointment_id": "#appointment_id"
    }
]
```

#### * Find all charts for an appointment:
    GET localhost:4040/appointment/#id/charts?user_token=#token

##### Response (Status: 200 Ok)
```JSON
[
    {
        "id": "#chart_id",
        "file_path": "#chart_loc",
        "created_at": "2020-10-20T23:57:23.340Z",
        "updated_at": "2020-10-20T23:57:23.340Z",
        "appointment_id": "#appointment_id"
    },
    {
        "id": "#chart_id",
        "file_path": "#chart_loc",
        "created_at": "2020-10-20T23:57:23.364Z",
        "updated_at": "2020-10-20T23:57:23.364Z",
        "appointment_id": "#appointment_id"
    },
    {
        "id": "#chart_id",
        "file_path": "#chart_loc",
        "created_at": "2020-10-20T23:57:23.374Z",
        "updated_at": "2020-10-20T23:57:23.374Z",
        "appointment_id": "#appointment_id"
    }
]
```

#### * Download a chart for an appointment:
    GET localhost:4040/appointment/#id/charts/#chart_id?user_token=#token

##### Response (Status: 200 Ok)
```
It will directly download the file via browser
```

#### * Upload consultation summary for appointment:
    POST localhost:4040/appointment/#id/consultation_summary?user_token=#token

##### Request Body
```
type_of_body: form-data
-----------
key : value
-----------
file: #{file_data}
```

##### Response (Status: 200 Ok)
```JSON
{
    "appointment_id": "#appointment_id",
    "file_path": "#summary_loc",
    "created_at": "2020-10-21T00:03:54.413Z",
    "updated_at": "2020-10-21T00:03:54.413Z"
}
```

#### * Download a consultation summary for an appointment:
    GET localhost:4040/appointment/#id/consultation_summary?user_token=#token

##### Response (Status: 200 Ok)
```
It will directly download the file via browser
```

### Under construction
* Add billing codes for appointments.
* View all appointments for user (BLOCKED: Require user authorization)
* Delete appointments (BLOCKED: Require user authorization)
* Create tele-visit session for appointments