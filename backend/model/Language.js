var mongoose = require('mongoose');
var languageSchema = new mongoose.Schema({
  language: {
    type: String,
    unique: true
  }
<<<<<<< Updated upstream
=======
},{
    versionKey: false // You should be aware of the outcome after set to false
>>>>>>> Stashed changes
});

mongoose.model('Language', languageSchema);

module.exports = mongoose.model('Language');
