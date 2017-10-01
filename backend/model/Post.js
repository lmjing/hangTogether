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
<<<<<<< HEAD
<<<<<<< Updated upstream
    message: String
=======
=======
>>>>>>> d24634c134a2223ba5206760384aa1375c4c6eca
    message: String,
    date: {
      type: Date,
      min: Date.now
    }
<<<<<<< HEAD
>>>>>>> Stashed changes
=======
>>>>>>> d24634c134a2223ba5206760384aa1375c4c6eca
  }],
  guide: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    default: null
  }
<<<<<<< HEAD
<<<<<<< Updated upstream
=======
},{
    versionKey: false // You should be aware of the outcome after set to false
>>>>>>> Stashed changes
=======
},{
    versionKey: false // You should be aware of the outcome after set to false
>>>>>>> d24634c134a2223ba5206760384aa1375c4c6eca
});

mongoose.model('Post', postSchema);

module.exports = mongoose.model('Post');
