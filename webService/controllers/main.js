var express = require('express');
var router = express.Router();

var myDb = require('../db');
var dbname = "Law";

router.get('/data/', function(req, res) {
  console.log(req.query);
  var categories = req.query.keywords;
  if (typeof categories === 'string') {
    var temp = categories
    categories = [];
    categories.push(temp); 
    console.log(categories);
  }
  var collection = myDb.get().collection(dbname);
  collection.find({'category': { '$all' : categories }}).toArray(function(err, data) {
    res.send(data);
  });
});

module.exports = router;
