var express = require('express');
var router = express.Router();

var User = require('../model/User');
var Post = require('../model/Post');

router.post('/', function(req, res) {
  User.findOne({ id: req.body.writer }, function(err, writer) {
    if (err) {
      console.log('writer id를 찾을 수 없습니다.');
      return res.status(400).send('writer id를 찾을 수 없습니다.');
    }

    Post.create({
      writer: writer,
      content: req.body.content,
      trip: req.body.trip
    }, function(err, post) {
      if (err) {
        console.log('Post 생성 실패');
        return res.status(500).send('Post 생성 실패');
      }
      return res.status(200).send(post);
    });
  })
});

module.exports = router;
