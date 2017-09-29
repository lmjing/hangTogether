var mongoose = require('mongoose');
var countrySchema = new mongoose.Schema({
  name: String,
  imageUrl: String
});

mongoose.model('Country', countrySchema);

module.exports = mongoose.model('Country');
