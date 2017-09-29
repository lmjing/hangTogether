var express = require('express');
var router = express.Router();

var Country = require('../model/Country');

router.post('/', function(req, res) {
  Country.create({
    name: req.body.name,
    imageUrl: req.body.imageUrl
  }, function(err, country) {
    if (err) return res.status(500).send('Country 생성 실패');
    return res.status(200).send(country);
  });
});

module.exports = router;
