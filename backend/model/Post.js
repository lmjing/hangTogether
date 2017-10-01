var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var postSchema = new Schema({
  writer: {
    type: Schema.Types.ObjectId,
    ref: 'User'
  },
  created: {
    type: Date,
    default: Date.now
  },
  content: {
    type: String,
  },
  tripDate: {
    start: {
      type: Date,
      min: Date.now
    },
    end: {
      type: Date,
      min: Date.now
    }
  },
  trip: [{
    date: {
      type: Date,
      min: Date.now
    },
    place: {
      name: String,
      address: String
    }
  }],
  recruiting: {
    type: Boolean,
    default: true
  },
  guide: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    default: null
  },
  volunteer: [{
    user: {
      type: Schema.Types.ObjectId,
      ref: 'User'
    },
    message: {
      type: String,
      default: null
    },
    dates: [{
      type: Date,
      min: Date.now
    }]
  }]
},{
    versionKey: false // You should be aware of the outcome after set to false
});

mongoose.model('Post', postSchema);

module.exports = mongoose.model('Post');
