var express = require('express');
var db = require('./db');
var app = express();

app.use('/', require('./controllers/main'));

var url = 'mongodb://yevayu:jYuv2nTQvSeAV38EduMZ8bkAdGKSHjaugRPPZAQ9MUDJPJ1QsOpXXkhGmkaY8Z8nqFW2diQTDO1BFtpr98aAIQ==@yevayu.documents.azure.com:10250/?ssl=true';
console.log('Initiating connection...');
db.connect(url, function(err, db) {
  if (err) {
    console.log('Error connecting to server');
    process.exit(1);
  } else {
    app.listen(3000, function() {
      console.log("listing on port 3000");
    });
  }
});
