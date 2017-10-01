var express = require('express');
var router = express.Router();

var Language = require('../model/Language');

router.post('/', function(req, res) {
<<<<<<< Updated upstream
  Language.create({
    language: req.body.language
  }, function(err, language) {
    if (err) return res.status(500).send('Language 생성 실패');
    return res.status(200).send(language);
=======
  var language = new Language({
    language: req.body.language
  });
  language.save()
  .then((language) => {
    return res.status(201).json(language);
  })
  .catch((err) => {
  console.log(err);
    if (err.name == 'ValidationError') {
      return res.status(400).json('invalid input, object invalid.');
    }else if (err.name == 'MongoError') {
      return res.status(409).json('an existing item already exists');
    }
    return res.status(500).json('internal server error');
  });
});

router.get('/', function(req, res) {
  Language.find({})
  .then((results) => {
    if(results) {
      return res.status(200).json(results);
    }
    return res.status(404).json('not found');
  })
  .catch((err) => {
    console.log(err);
    return res.status(500).json('internal server error');
>>>>>>> Stashed changes
  });
});

module.exports = router;
