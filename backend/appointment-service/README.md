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

#### * Get all appointments based on patient_id or doctor_id: 
    GET localhost:4040/appointment?patient_id=#ID

##### Constraints
```
patient_id or doctor_id should be present. 

Appointment Status
------------------
PENDING = 0
ACTIVE = 1
ENDED = 2
CANCELLED = 3

Filters Available
------------------
1. from: YYYY-MM-DDThh-mm
2. to: YYYY-MM-DDThh-mm
3. appointment_status : 0 - 3
```
##### Response (Status: 201 Created)
```JSON
    [{
        "appointment_id": "#appointment_id",
        "patient_id": "#patient_id",
        "start_time": "#start_time",
        "end_time": "#end_time",
        "doctor_id": "#doctor_id",
        "appointment_status": "#status",
        "created_at": "2020-10-20T23:43:22.496Z",
        "updated_at": "2020-10-20T23:43:22.496Z"
    },
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
]
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

#### * Post billing codes to an appointment:
    POST localhost:4040/appointment/#id/billing_codes?user_token=#token
##### Request Body
```JSON
{
    "billing_codes": "F01, F02, F03, B17"
} 
```
##### Response (Status: 201 Created)
```JSON
{
    [
        {
            "id": 1,
            "code": "F01",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.525Z",
            "updated_at": "2020-11-06T18:26:00.525Z"
        },
        {
            "id": 2,
            "code": " F02",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.535Z",
            "updated_at": "2020-11-06T18:26:00.535Z"
        },
        {
            "id": 3,
            "code": " F03",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.538Z",
            "updated_at": "2020-11-06T18:26:00.538Z"
        },
        {
            "id": 4,
            "code": " B17",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.541Z",
            "updated_at": "2020-11-06T18:26:00.541Z"
        }
    ]
}
```
#### * Get billing codes to an appointment:
    POST localhost:4040/appointment/#id/billing_codes?user_token=#token
##### Response (Status: 200 Ok)
```JSON
{
    [
        {
            "id": 1,
            "code": "F01",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.525Z",
            "updated_at": "2020-11-06T18:26:00.525Z"
        },
        {
            "id": 2,
            "code": " F02",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.535Z",
            "updated_at": "2020-11-06T18:26:00.535Z"
        },
        {
            "id": 3,
            "code": " F03",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.538Z",
            "updated_at": "2020-11-06T18:26:00.538Z"
        },
        {
            "id": 4,
            "code": " B17",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.541Z",
            "updated_at": "2020-11-06T18:26:00.541Z"
        }
    ]
}
```

#### * Cancel an appointment:
    DELETE localhost:4040/appointment/#id?doctor_id=#doctor_id

##### Constraint
```
patient_id or doctor_id is required to work.
```

##### Request Body
```JSON
{
    "cancel_reason": "testing from patient."
}
```

##### Response (Status 200 Ok)
```JSON
{
    "appointment_id": 22,
    "cancel_reason": "testing from patient.",
    "doctor_id": 2,
    "created_at": "2020-11-09T05:52:44.173Z",
    "updated_at": "2020-11-09T05:52:44.173Z"
}
```

#### * Generate a report of an appointment:
    GET localhost:4040/appointment/#id/report
##### Constraint
```
cancelled_appointment will only be present if the appointment is cancelled.
```
##### Response (Status: 200 Ok)
```JSON
{
    "appointment": {
        "appointment_id": 20,
        "patient_id": 2,
        "start_time": "2020-11-10T17:50:00.000Z",
        "end_time": "2020-11-10T17:51:00.000Z",
        "doctor_id": 2,
        "appointment_status": 0,
        "created_at": "2020-11-06T17:40:11.184Z",
        "updated_at": "2020-11-06T17:40:11.184Z"
    },
    "charts": [
        {
            "id": 7,
            "file_path": "storage/20_chart_TECH FAQ.pdf",
            "created_at": "2020-11-06T19:45:43.647Z",
            "updated_at": "2020-11-06T19:45:43.647Z",
            "appointment_id": 20
        },
        {
            "id": 8,
            "file_path": "storage/20_chart_Aetna Insurance Card.pdf",
            "created_at": "2020-11-06T19:45:43.663Z",
            "updated_at": "2020-11-06T19:45:43.663Z",
            "appointment_id": 20
        },
        {
            "id": 9,
            "file_path": "storage/20_chart_NJ Institute of Technology Mail - EssexCOVID.org - You are eligible for a test.pdf",
            "created_at": "2020-11-06T19:45:43.679Z",
            "updated_at": "2020-11-06T19:45:43.679Z",
            "appointment_id": 20
        }
    ],
    "consultationSummary": {
        "appointment_id": 20,
        "file_path": "storage/20_summary_Aetna Insurance Card.pdf",
        "created_at": "2020-11-06T19:45:58.979Z",
        "updated_at": "2020-11-06T19:45:58.979Z"
    },
    "cancelled_appointment": {
        "appointment_id": 1,
        "cancel_reason": "testing from patient.",
        "patient_id": 1,
        "created_at": "2020-11-09T05:34:59.824Z",
        "updated_at": "2020-11-09T05:34:59.824Z"
    },
    "billingCodes": [
        {
            "id": 1,
            "code": "F01",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.525Z",
            "updated_at": "2020-11-06T18:26:00.525Z"
        },
        {
            "id": 2,
            "code": " F02",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.535Z",
            "updated_at": "2020-11-06T18:26:00.535Z"
        },
        {
            "id": 3,
            "code": " F03",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.538Z",
            "updated_at": "2020-11-06T18:26:00.538Z"
        },
        {
            "id": 4,
            "code": " B17",
            "appointment_id": 20,
            "created_at": "2020-11-06T18:26:00.541Z",
            "updated_at": "2020-11-06T18:26:00.541Z"
        }
    ],
    "appointment_duration": {
        "duration": 60,
        "unit": "seconds"
    },
    "tele_visit": {
        "visit": {
            "appointment_id": 20,
            "session_id": "2_MX40Njk1MDMyNH5-MTYwNDY4NDQxMTcxMH5JL1BmR3diSElhRWorV2RhMDFMR2JTUmV-UH4",
            "patient_token": "T1==cGFydG5lcl9pZD00Njk1MDMyNCZzaWc9MDRiZjJmMjdmZDNiZTRhNjU4NjY4NzU1YWRiMjNiMTc3OGE2MDgyNjpyb2xlPXB1Ymxpc2hlciZzZXNzaW9uX2lkPTJfTVg0ME5qazFNRE15Tkg1LU1UWXdORFk0TkRReE1UY3hNSDVKTDFCbVIzZGlTRWxoUldvclYyUmhNREZNUjJKVFVtVi1VSDQmY3JlYXRlX3RpbWU9MTYwNDY4NDQxMSZub25jZT0wLjA5OTgyMDU3Nzk2MjI4ODY=",
            "doctor_token": "T1==cGFydG5lcl9pZD00Njk1MDMyNCZzaWc9ODJjNWVmZGE2MzQzMzg1MWQ4NDVhMWM4MWIxZGVmYjgyYjZiMDJhYjpyb2xlPXB1Ymxpc2hlciZzZXNzaW9uX2lkPTJfTVg0ME5qazFNRE15Tkg1LU1UWXdORFk0TkRReE1UY3hNSDVKTDFCbVIzZGlTRWxoUldvclYyUmhNREZNUjJKVFVtVi1VSDQmY3JlYXRlX3RpbWU9MTYwNDY4NDQxMSZub25jZT0wLjYxNTY0MDM1NzEzNTYxMTc=",
            "started_at": "2020-11-06T19:38:06.640Z",
            "ended_at": "2020-11-06T19:40:23.014Z",
            "status": 2,
            "created_at": "2020-11-06T17:40:11.759Z",
            "updated_at": "2020-11-06T19:40:23.014Z"
        },
        "televisit_duration": {
            "duration": 137,
            "unit": "seconds"
        }
    }
}
```
#### * GET cancelled appointments for practise or patient:
    GET localhost:4040/cancelled_appointments?doctor_id=#id

##### Constraint
```
patient_id or doctor_id is required to work.
Filters Available
------------------
1. from: YYYY-MM-DDThh-mm
2. to: YYYY-MM-DDThh-mm
3. appointment_id
```

##### Response (Status: 200 Ok)
```JSON
[
    {
        "appointment_id": 6,
        "cancel_reason": "testing from patient.",
        "doctor_id": 2,
        "created_at": "2020-11-09T05:46:05.491Z",
        "updated_at": "2020-11-09T05:46:05.491Z"
    },
    {
        "appointment_id": 22,
        "cancel_reason": "testing from patient.",
        "doctor_id": 2,
        "created_at": "2020-11-09T05:52:44.173Z",
        "updated_at": "2020-11-09T05:52:44.173Z"
    },
    {
        "appointment_id": 25,
        "cancel_reason": "testing from patient.",
        "doctor_id": 2,
        "created_at": "2020-11-09T05:51:59.652Z",
        "updated_at": "2020-11-09T05:51:59.652Z"
    }
]
```