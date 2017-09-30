var express = require('express');
var router = express.Router();
var moment = require('moment');

var User = require('../model/User');
var Post = require('../model/Post');

router.get('/', function(req, res) {

  var ageArea = req.query.age;
  var ageStartDate = moment().add(-24, 'years').calendar();
  console.log(ageStartDate);

  return res.status(500).json('internal server error');

  // Post.find({ $or : [{writer: {birth}} {age: req.query.age}, {startDate: req.query.startDate}, {endDate:}]})
  // .then((results) => {
  //   if(results) {
  //     return res.status(200).json(results);
  //   }
  //   return res.status(404).json('not found');
  // })
  // .catch((err) => {
  //   console.log(err);
  //   return res.status(500).json('internal server error');
  // });
});

module.exports = router;
