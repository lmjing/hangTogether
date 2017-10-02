var mongoose = require('mongoose');
var languageSchema = new mongoose.Schema({
  area: String,
  english: String,
  code: String,
  language: {
    type: String,
    unique: true
  }
},{
    versionKey: false // You should be aware of the outcome after set to false
});

mongoose.model('Language', languageSchema);

module.exports = mongoose.model('Language');
