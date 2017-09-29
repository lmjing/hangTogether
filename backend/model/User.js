var mongoose = require('mongoose');
var Schema = mongoose.Schema;

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
  country: { //Country에서 찾아서 참조로 넣을 것(나중에 imageUrl도 가져와댜 하구..
    type: Schema.Types.ObjectId,
    ref: 'Country'
  },
  name: String,
  introduce: {
    type: String,
    default: null
  },
  language: {
    type: String,
    default: 'Korean'
  } // 추후 Model만들어서 연결해야 할 수도 있을 듯.(단어 장 때문에...?)
});

mongoose.model('User', userSchema);

module.exports = mongoose.model('User');
