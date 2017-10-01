var mongoose = require('mongoose');
var languageSchema = new mongoose.Schema({
  language: {
    type: String,
    unique: true
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

mongoose.model('Language', languageSchema);

module.exports = mongoose.model('Language');
