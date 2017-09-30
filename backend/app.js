var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var mongoose = require('mongoose');
const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./swagger.json');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var users = require('./router/Users');
var languages = require('./router/Languages');
var posts = require('./router/Posts');

app.use('/user', users);
app.use('/language', languages);
app.use('/post', posts);

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.listen(3000, function() {
  console.log('서버돌아가는 중 ~~');
});

var promise = mongoose.connect('mongodb://localhost:27017/hangTogether', {
  useMongoClient: true
});

var db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function() {
    console.log('connected successfully');
});
