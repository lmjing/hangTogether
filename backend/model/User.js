var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Language = require('../model/Language');

var userSchema = new Schema({
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
  type: {
    type: String,
    enum: ['korean','foreigner']
  },
  languages: [{
    type: String
  }],
  introduce: {
    type: String,
    default: null,
    maxlength: 100
  }
},{
    versionKey: false // You should be aware of the outcome after set to false
});

mongoose.model('User', userSchema);

module.exports = mongoose.model('User');
