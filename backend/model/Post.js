var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var postSchema = new Schema({
  writer: {
    type: Schema.Types.ObjectId,
    ref: 'User'
  },
  created: {
    type: Date,
    max: Date.now
  },
  recruiting: {
    type: Boolean,
    default: true
  },
  content: String,
  trip: [{
    date: {
      type: Date,
      min: Date.now
    },
    place: String,
    address: String
  }],
  volunteer: [{
    user: {
      type: Schema.Types.ObjectId,
      ref: 'User'
    },
    message: String
  }],
  guide: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    default: null
  }
},{
    versionKey: false // You should be aware of the outcome after set to false
});

mongoose.model('Post', postSchema);

module.exports = mongoose.model('Post');
