var express = require('express');
var router = express.Router();

var Language = require('../model/Language');

router.get('/', function(req, res) {
  Language.find({})
  .select('language')
  .then((results) => {
    if(results) {
      var languages = results.map((data) => {
        return data.language
      })
      return res.status(200).json(languages);
    }
    return res.status(404).json('not found');
  })
  .catch((err) => {
    console.log(err);
    return res.status(500).json('internal server error');
  });
});

module.exports = router;
