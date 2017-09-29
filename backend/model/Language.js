var mongoose = require('mongoose');
var languageSchema = new mongoose.Schema({
  language: {
    type: String,
    unique: true
  }
});

mongoose.model('Language', languageSchema);

module.exports = mongoose.model('Language');
