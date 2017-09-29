var mongoose = require('mongoose');
var languageSchema = new mongoose.Schema({
  language: String
});

mongoose.model('Language', languageSchema);

module.exports = mongoose.model('Language');
