// replace these values with those generated in your TokBox Account
var apiKey = "46950324";
var sessionId = "2_MX40Njk1MDMyNH5-MTYwNDg5Mzg5MzAwMH5wdndpN0pxSWZWaVNFQitab3NUa3lmU1B-UH4";
var token = "T1==cGFydG5lcl9pZD00Njk1MDMyNCZzaWc9ZWUzODBmYjdkMDIxOGY4OWE5YTJiOTRiMDg2MDVlYWFiMDEzZDY0Nzpyb2xlPXB1Ymxpc2hlciZzZXNzaW9uX2lkPTJfTVg0ME5qazFNRE15Tkg1LU1UWXdORGc1TXpnNU16QXdNSDV3ZG5kcE4wcHhTV1pXYVZORlFpdGFiM05VYTNsbVUxQi1VSDQmY3JlYXRlX3RpbWU9MTYwNDg5Mzg5MyZub25jZT0wLjExNjg0NTkyNDQ2NTg4MTgyJmV4cGlyZV90aW1lPTE2MDc0ODU4OTM=";

var publisher;
var session;

// Wait for page to load
document.addEventListener('DOMContentLoaded', function() {

  // (optional) add server code here
  initializeSession();

  // Handling all of our errors here by alerting them
  function handleError(error) {
    if (error) {
      alert(error.message);
    }
  }

  function initializeSession() {
    session = OT.initSession(apiKey, sessionId);

    // Create a publisher
    publisher = OT.initPublisher('publisher', {}, handleError);
    session.connect(token, function(err) {
       // publish publisher
       session.publish(publisher);
    });


    // Subscribe to a newly created stream
    // create subscriber
    session.on('streamCreated', function(event) {
       session.subscribe(event.stream, 'subscriber');
    });

  }

});