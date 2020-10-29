document.addEventListener('DOMContentLoaded', function() {

  // Get Today's date
  var todaysDate = new Date().toJSON().slice(0,10);
  console.log(todaysDate)

  // Create Calendar
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay'
    },
    initialView: 'timeGridWeek',
    initialDate: todaysDate,
    navLinks: true, // can click day/week names to navigate views
    nowIndicator: true,

    weekNumbers: true,
    weekNumberCalculation: 'ISO',

    editable: true,
    selectable: true,

    // TODO - API Call to other team?
    select: function(arg) {
      var addNewEvent = confirm('Add New Time Slot?');
      if (addNewEvent) {
        calendar.addEvent({
          title: 'Available',
          start: arg.start,
          end: arg.end,
          className: 'pp-calendar-open'
        })
      }
      calendar.unselect()
    },

    dayMaxEvents: true, // allow "more" link when too many events
    events: [
      {
        title: 'Smith, John',
        start: '2020-10-30T10:30:00',
        end: '2020-10-30T12:30:00',
        className: 'pp-calendar-booked'
      },
      {
        title: 'Available',
        start: '2020-10-30T09:00:00',
        end: '2020-10-30T10:00:00',
        className: 'pp-calendar-open'
      },
      {
        title: 'Available',
        start: '2020-10-30T13:00:00',
        end: '2020-10-30T14:00:00',
        className: 'pp-calendar-open'
      },
      {
        title: 'Adams, Jane',
        start: '2020-10-30T15:00:00',
        end: '2020-10-30T16:00:00',
        className: 'pp-calendar-booked'
      },
      {
        title: 'Cancellation',
        start: '2020-10-30T16:30:00',
        end: '2020-10-30T17:30:00',
        className: 'pp-calendar-cancelled'
      }
    ]
  });

  calendar.render();


  // Modal Listener: Book Open Appointment
  $(document).on('click', '.pp-calendar-open', function(){
    $('#openAptModal').modal('show');
  });

  // Modal Listener: Cancel Booked Appointment
  $(document).on('click', '.pp-calendar-booked', function(){
    $('#bookedAptModal').modal('show');
  });

  // Modal Listener: View Cancellation
  $(document).on('click', '.pp-calendar-cancelled', function(){
    $('#cancelledAptModal').modal('show');
  });

});