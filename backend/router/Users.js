var express = require('express');
var router = express.Router();

var Country = require('../model/Country');
var User = require('../model/User');

router.post('/', function(req, res) {
  Country.findOne({ name: req.body.country }, function(err, country) {
    if (err) {
      console.log("찾는 국가가 없습니다.");
      return res.status(400).send("찾는 국가가 없습니다.");
    }else {
      User.create({
        id: req.body.id,
        password: req.body.password,
        email: req.body.email,
        sex: req.body.sex,
        birth: req.body.birth,
        profileUrl: req.body.profileUrl,
        country: country._id,
        name: req.body.name,
        introduce: req.body.introduce,
        language: req.body.language
      },function(err, user){
        if (err) {
          console.log("User 생성 실패", err.message);
          return res.status(500).send("User 생성 실패");
        }else {
          console.log("User 생성 성공");
          return res.status(200).send(user);
        }
      });
    }
  });


});

router.get('/', function(req, res) {
  User.find({}, function(err, users) {
    if (err) {
      console.log("User 목록 조회 실패", err);
      return res.status(500).send("User 목록 조회 실패");
    }else {
      console.log("User 목록 조회 성공");
      return res.status(200).send(users);
    }
  });
});

router.get('/:id', function(req, res) {
  User.findOne({id : req.params.id})
  .populate('country')
  .exec(function(err, user){
    if(err) {
      console.log("User 조회 실패", err);
      return res.status(500).send("User 조회 실패");
    }
    console.log("User 조회 성공");
    return res.status(200).send(user);
 });
});

module.exports = router;
