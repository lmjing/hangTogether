var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Language = require('../model/Language');

var userSchema = new Schema({
  id: {
    type: String,
    index: true,
    unique: true
  },
  password: String,
  email: String,
  sex: {
    type: String,
    enum: ['male','female']
  },
  birth: {
    type: Date,
    max: Date.now,
    min: new Date('1850-01-01')
  },
  profileUrl: {
    type: String,
    default: null
  },
  name: String,
  introduce: {
    type: String,
    default: null
  },
  language: {
    type: String,
    default: 'Korean'
    //
    // validate: {
    //   validator: (language) => {
    //     Language.findOne({language: language})
    //     .exec(function(err, language){
    //       if(err) {
    //         return false;
    //       }
    //       return true;
    //    });
    //  },
    //  message: 'DB에서 제공하지 않는 언어입니다.'
    // }
  } // 추후 Model만들어서 연결해야 할 수도 있을 듯.(단어 장 때문에...?)
});

mongoose.model('User', userSchema);

module.exports = mongoose.model('User');
