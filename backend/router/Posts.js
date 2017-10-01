var express = require('express');
var router = express.Router();
var moment = require('moment');

var User = require('../model/User');
var Post = require('../model/Post');

router.post('/', function(req, res) {
  if (req.body.tripDate.start > req.body.tripDate.end){
    return res.status(400).json('invalid input, parameter invalid.');
  }

  User.findById(req.body.writer)
  .then((user) => {
    if(user) {
      var newPost = new Post({
        writer: user,
        content: req.body.content,
        tripDate: req.body.tripDate,
        trip: req.body.trip,
        volunteer: [],
        guide: []
      });

      newPost.save()
      .then((result) => {
        Post.findOne(result)
        .populate({path: 'writer'})
         .then((post) => {
           if (post) {
             return res.status(201).json(post);
           }
           return res.status(404).json('not found');
         })
         .catch((err) => {
           return res.status(500).json('internal server error');
         });
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
    }else {
      return res.status(404).json('user not found');
    }
  })
  .catch((err) => {
    if(err.name == 'CastError') {
      return res.status(404).json('not found');
    }
    return res.status(500).json('internal server error');
  });
});

router.get('/', function(req, res) {
    var queryList = [{'recruiting': true}]
    var writerQuery = {}

    // 나이대 옵션
    if(req.query.age) {
      var age = req.query.age;
      var ageEndDate = moment().add(-age, 'years').calendar();
      var ageStartDate = moment().add(-age - 10, 'years').calendar();
      if (age == 40) {
        ageStartDate = moment().add(-120, 'years').calendar();
      }

      writerQuery = {'birth': {
        $gte: new Date(ageStartDate), $lte: new Date(ageEndDate)
      }};
    }
    //여행 일정 옵션
    if(req.query.startDate || req.query.endDate) {
      if(req.query.startDate && req.query.endDate) {
        queryList.push({'tripDate.start': { $gte: new Date(req.query.startDate) }});
        queryList.push({'tripDate.end': { $lte: new Date(req.query.endDate) }});
      }else {
        return res.status(404).json('날짜 옵션은 출발/도착일 모두 입력해야 합니다.');
      }
    }
    // 성별 옵션
    if(req.query.sex) {
      writerQuery['sex'] = req.query.sex
    }

    var query = {}
    if(queryList.length > 0){
      query = {$and: queryList}
    }

    Post.find(query)
    .sort({ created: -1 })
    .populate({path: 'writer', match: writerQuery})
    .then((posts) => {
      if(posts) {
        var result = posts.filter((post) => {
          return post.writer != null
        });
        return res.status(200).json(result);
      }
      return res.status(404).json('not found');
    })
    .catch((err) => {
      console.log(err);
      return res.status(500).json('internal server error');
    });
});

router.get('/:id', function(req, res) {
  if(req.params.id == null){
    return res.status(400).json('bad input parameter');
  }

  Post.findById(req.params.id)
  .populate('writer')
  .populate('volunteer.user')
  .populate('guide')
  .then((post) => {
    if (post) {
      return res.status(200).json(post)
    }
    return res.status(400).json('error');
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
  if (!req.body.tripDate.start || !req.body.tripDate.end || req.body.trip.length == 0) {
    return res.status(400).json('invalid input, object invalid.');
  }

  Post.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true})
  .then((post) => {
    if(post) {
      return res.status(201).json(post);
    }else {
      return res.status(404).json('not found');
    }
  })
  .catch((err) => {
    console.log(err)
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

  Post.findByIdAndUpdate(
    req.params.id, {$set: {recruiting : false}}
  ).then((post) => {
    console.log('before')
    console.log(post)
    return Post.findById(req.params.id).exec()
  }).then((post) => {
    if(post) {
      console.log('after')
      console.log(post)
      return res.status(200).json(post)
    }
    return res.status(404).json('not found')
  })
})

router.put('/:id/apply', function(req, res) {
  if(!req.params.id){
    return res.status(400).json('bad input parameter');
  }
  if (!req.body.volunteer || req.body.dates.length == 0) {
    return res.status(400).json('invalid input, object invalid.');
  }

  var volunteerData = {
    'dates' : req.body.dates,
    'user': req.body.volunteer
  }
  if(req.body.message) {
    volunteerData['message'] = req.body.message
  }

  //우선 기존에 있던게 있다면 삭제함
  Post.findByIdAndUpdate(
    req.params.id,
    {$pull: {
      volunteer : { user: req.body.volunteer }
    }}
  ).then((post) => {
    console.log(post)
    if(post) {
      return Post.findByIdAndUpdate(
        req.params.id,
        { $push: { volunteer: volunteerData } }
      ).exec()
    }else{
      return res.status(404).json('not found');
    }
  }).then((post) => {
    if(post) {
      return res.status(201).json('신청됨');
    }else{
      return res.status(404).json('not found');
    }
  })
  .catch((err) => {
    console.log(err)
    if(err.name == 'CastError') {
      return res.status(404).json('not found');
    }
    return res.status(500).json('internal server error');
  });
});

// Test 요망
router.delete('/:id/apply', function(req, res){
  if(!req.params.id || !req.query.user ){
    return res.status(400).json('bad input parameter');
  }

  Post.findByIdAndUpdate(
    req.params.id,
    {$pull: {
      volunteer : { user: req.query.user }
    }}
  ).then((post) => {
    if(post) {
      return res.status(201).json('Success - 신청이 취소되었습니다.')
    }
    return res.status(409).json('Fail - 신청에 실패했습니다.')
  }).catch((err) => {
    console.log(err)
    return res.status(500).json('internal server error');
  });
})

router.get('/user/:id', function(req, res) {
  if(!req.params.id){
    return res.status(400).json('bad input parameter');
  }
  Post.find({
    writer: req.params.id
  }).sort({ created: -1 })
  .populate('writer')
  .populate('volunteer.user')
  .populate('guide')
  .then((posts) => {
    if(posts.length > 0) {
      res.status(200).json(posts)
    }
    res.status(404).json('not found')
  }).catch((err) => {
    console.log(err)
    return res.status(500).json('internal server error');
  });
})
module.exports = router;
