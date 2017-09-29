var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var messageSchema = new Schema({
});

mongoose.model('Message', messageSchema);

module.exports = mongoose.model('Message');
