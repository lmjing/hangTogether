var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Language = require('../model/Language');

var userSchema = new Schema({
<<<<<<< Updated upstream
  id: {
    type: String,
    index: true,
    unique: true
  },
  password: String,
  email: String,
=======
  email: {
    type: String,
    index: true,
    unique: true,
    validate: {
      validator: function(email) {
        return /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/.test(email);
      },
      message: 'The e-mail field cannot be empty.'
    }
  },
  password: String,
  nickname: {
    type: String,
    unique: true
  },
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
  type: {
    type: String,
    enum: ['korean','foreigner']
  },
  languages: [{
    language: {
      type: String
    }
  }],
  introduce: {
    type: String,
    default: null,
    maxlength: 100
  }
},{
    versionKey: false // You should be aware of the outcome after set to false
>>>>>>> Stashed changes
});

mongoose.model('User', userSchema);

module.exports = mongoose.model('User');
