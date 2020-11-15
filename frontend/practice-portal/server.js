const express = require('express');
const app = express();
const port = process.env.PORT || 3000; // Select either local port or Heroku default

// set the view engine to ejs
app.set('view engine', 'ejs');
// server static assets (ex css, js, vendor)
app.use(express.static('public'));

// index page
app.get('/', function(req, res) {
    res.render('pages/index');
});

// calendar
app.get('/calendar', function(req, res) {
    res.render('pages/calendar');
});

// televisit
app.get('/televisit', function(req, res) {
    res.render('pages/televisit');
});


// CATCH ALL ROUTE
app.get('*', function(req, res) {
  res.send("Invalid Page, redirect to Login Page for Practice Portal")
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
})