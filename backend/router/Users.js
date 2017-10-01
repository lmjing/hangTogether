const express = require('express');
const router = express.Router();
var moment = require('moment');

const Language = require('../model/Language');
const User = require('../model/User');

router.get('/check', function(req, res) {
  var email = req.query.email;
  var nickname = req.query.nickname;

  if (email != null) {
    if (nickname != null) {
      return res.status(400).json('이메일, 닉네임 동시 중복확인은 불가합니다.');
    }
    User.findOne({ email : email })
     .then((user) => {
       if (user == null) {
         return res.status(200).json('사용 가능');
       }else {
         return res.status(409).json('이미 존재하는 이메일입니다.');
       }
     })
     .catch((err) => {
       return res.status(500).json('internal server error');
     });
  }else if (nickname != null) {
    User.findOne({ nickname : nickname })
     .then((user) => {
       if (user == null) {
         return res.status(200).json('사용 가능');
       }else {
         return res.status(409).json('이미 존재하는 닉네임입니다.');
       }
     })
     .catch((err) => {
       return res.status(500).json('internal server error');
     });
  }else {
    return res.status(400).send('bad input parameter')
  }
});

router.post('/', function(req, res) {
  var newUser = new User({
    email: req.body.email,
    password: req.body.password,
    nickname: req.body.nickname,
    sex: req.body.sex,
    birth: req.body.birth,
    profileUrl: req.body.profileUrl,
    type: req.body.type,
    languages: req.body.languages,
    introduce: req.body.introduce
  });

  newUser.save()
  .then((user) => {
    return res.status(201).json(user);
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
  User.find({})
   .then((userList) => {
     return res.status(200).json(userList);
   })
   .catch((err) => {
     console.log(err);
     return res.status(404).json("User 목록 조회 실패");
   });
});

router.get('/:id', function(req, res) {
  if(req.params.id == null){
    return res.status(400).json('bad input parameter');
  }

  User.findById(req.params.id)
  .then((user) => {
    if(user) {
      return res.status(200).json(user);
    }
    return res.status(404).json('not found');
  })
  .catch((err) => {
    if(err.name == 'CastError') {
      return res.status(404).json('not found');
    }
    return res.status(500).json('internal server error');
  });
});

router.put('/:id', function(req, res) {
  if(!req.params.id){
    return res.status(400).json('bad input parameter');
  }
  if (!req.body.password || !req.body.nickname || !req.body.introduce ) {
    return res.status(400).json('invalid input, object invalid.');
  }

  User.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true})
  .then((user) => {
    if(user) {
      return res.status(201).json(user);
    }else {
      return res.status(404).json('not found');
    }
  })
  .catch((err) => {
    if(err.name == 'CastError') {
      return res.status(404).json('not found');
    }
    return res.status(500).json('internal server error');
  });
});

router.delete('/:id', function(req, res) {
  if(!req.params.id){
    return res.status(400).json('bad input parameter');
  }

  User.findByIdAndRemove(req.params.id)
  .then((user) => {
    if(user) {
      return res.status(201).json('success - not found');
    }else {
      return res.status(404).json('not found');
    }
  }).catch((err) => {
    if(err.name == 'CastError') {
      return res.status(404).json('not found');
    }
    return res.status(500).json('internal server error');
  });
})

module.exports = router;
