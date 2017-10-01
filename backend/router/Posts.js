var express = require('express');
var router = express.Router();
<<<<<<< Updated upstream
=======
var moment = require('moment');
>>>>>>> Stashed changes

var User = require('../model/User');
var Post = require('../model/Post');

<<<<<<< Updated upstream
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
=======
router.get('/', function(req, res) {
  var age = req.query.age;
  var ageEndDate = moment().add(-age, 'years').calendar();
  var ageStartDate = moment().add(-age - 10, 'years').calendar();
  if (age == 40) {
    ageStartDate = moment().add(-120, 'years').calendar();
  }
  console.log(ageStartDate);
  console.log(ageEndDate);

  Post.find({
    // $or :[{
      writer: {
          birth:{$gte: ageStartDate, $lte: ageEndDate}
      }
    // }]
  })
  .populate('writer')
  .then((results) => {
    if(results) {
      return res.status(200).json(results);
    }
    return res.status(404).json('not found');
  })
  .catch((err) => {
    console.log(err);
    return res.status(500).json('internal server error');
  });
>>>>>>> Stashed changes
});

module.exports = router;
