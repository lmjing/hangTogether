var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var postSchema = new Schema({
  title: {
    type: String,
    maxlength: 20
  },
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
    maxlength: 200
  },
  tripDate: {
    start: Date,
    end: Date
  },
  trip: [{
    date: {
      type: Date,
      default: null
    },
    places: [{
      name: String,
      address: {
        type: String,
        default: null
      },
      lat: {
	type: Number,
	default: null
      },
      lng: {
	type: Number,
	default: null
      }
    }]
  }],
  recruiting: {
    type: Boolean,
    default: true
  },
  guide: [{
    type: Schema.Types.ObjectId,
    ref: 'User'
  }],
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
