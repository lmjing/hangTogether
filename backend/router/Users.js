var express = require('express');
var router = express.Router();

var Language = require('../model/Language');
var User = require('../model/User');

router.get('/check', function(req, res) {
  var email = req.query.email;
  var nickname = req.query.nickname;

  if (email != null) {
    if (nickname != null) {
      return res.status(400).json('이메일, 닉네임 동시 중복확인은 불가합니다.');
    }
    User.findOne({ email: email })
    .exec(function(err, user){
      if(err) {
        return res.status(200).json('사용 가능');
      }
      return res.status(409).json('이미 존재하는 이메일입니다.');
    });
  }else if (nickname != null) {
    User.findOne({ nickname: nickname })
    .exec(function(err, user){
      if(err) {
        return res.status(200).json('사용 가능');
      }
      return res.status(409).json('이미 존재하는 닉네임입니다.');
    });
  }else {
    return res.status(400).send('bad input parameter')
  }
});

router.post('/', function(req, res) {
  User.create({
    email: req.body.email,
    password: req.body.password,
    nickname: req.body.nickname,
    sex: req.body.sex,
    birth: req.body.birth,
    profileUrl: req.body.profileUrl,
    type: req.body.type,
    languages: req.body.languages,
    introduce: req.body.introduce
  },function(err, user){
    if (err) {
      console.log("User 생성 실패", err.message);
      return res.status(500).send("User 생성 실패");
    }else {
      console.log("User 생성 성공");
      return res.status(200).send(user);
    }
  });

  //만약 언어를 참조? 한다면
  // Language.findOne({ name: req.body.language }, function(err, language) {
  //   if (err) {
  //     console.log("찾는 국가가 없습니다.");
  //     return res.status(400).send("찾는 국가가 없습니다.");
  //   }else {
  //     User.create({
  //       id: req.body.id,
  //       password: req.body.password,
  //       email: req.body.email,
  //       sex: req.body.sex,
  //       birth: req.body.birth,
  //       profileUrl: req.body.profileUrl,
  //       language: language,
  //       name: req.body.name,
  //       introduce: req.body.introduce,
  //       language: req.body.language
  //     },function(err, user){
  //       if (err) {
  //         console.log("User 생성 실패", err.message);
  //         return res.status(500).send("User 생성 실패");
  //       }else {
  //         console.log("User 생성 성공");
  //         return res.status(200).send(user);
  //       }
  //     });
  //   }
  // });
});

router.get('/', function(req, res) {
  User.find({}, function(err, users) {
    if (err) {
      console.log("User 목록 조회 실패", err);
      return res.status(500).json('User 목록 조회 실패');
    }else {
      console.log('User 목록 조회 성공');
      return res.status(200).json(users);
    }
  });
});

router.get('/:email', function(req, res) {
  User.findOne({email : req.params.email})
  // .populate('country')
  .exec(function(err, user){
    if(err) {
      console.log("User 조회 실패", err);
      return res.status(500).json("User 조회 실패");
    }
    console.log("User 조회 성공");
    return res.status(200).json(user);
 });
});

module.exports = router;
