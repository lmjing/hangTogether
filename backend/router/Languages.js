var express = require('express');
var router = express.Router();

var Language = require('../model/Language');

router.post('/', function(req, res) {
  Language.create({
    language: req.body.language
  }, function(err, language) {
    if (err) return res.status(500).send('Language 생성 실패');
    return res.status(200).send(language);
  });
});

module.exports = router;
