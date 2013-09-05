//setup Dependencies
var connect = require('connect')
  , express = require('express')
  , io = require('socket.io')
  , port = (process.env.PORT || 8081)
  , mongoose = require('mongoose')
  , Schema = mongoose.Schema
  , mongooseAuth = require('mongoose-auth');

//Setup Mongoose Auth
var UserSchema = new Schema({})
  , User;
UserSchema.plugin(mongooseAuth, {
  everymodule: {
    everyauth: {
      User: function () {
        return User;
      }
    }
  },
  password   : {
    everyauth: {
      loginWith: 'email',
      getLoginPath           : '/login',
      postLoginPath          : '/login',
      loginView              : 'login.jade',
      getRegisterPath        : '/register',
      postRegisterPath       : '/register',
      registerView           : 'register.jade',
      loginSuccessRedirect   : '/',
      registerSuccessRedirect: '/'
    }
  }
});

//Setup Mongoose
mongoose.model('User', UserSchema);
mongoose.connect('mongodb://localhost/haushaltsbuch');

//Init User
User = mongoose.model('User');

//Setup Express
var server = express.createServer();
server.configure(function () {
  server.set('views', __dirname + '/views');
  server.set('view options', { layout: false });
  server.use(connect.bodyParser());
  server.use(express.cookieParser());
  server.use(express.session({ secret: "someSecret12311!012;;"}));
  server.use(connect.static(__dirname + '/static'));
  server.use(mongooseAuth.middleware());
  server.use(server.router);
  server.use(express.errorHandler());
});

//setup the errors
server.error(function (err, req, res, next) {
  if (err instanceof NotFound) {
    res.render('404.jade', { locals: {
      title: '404 - Not Found', description: '', author: ''
    }, status                      : 404 });
  } else {
    res.render('500.jade', { locals: {
      title: 'The Server Encountered an Error', description: '', author: '', error: err
    }, status                      : 500 });
  }
});
server.listen(port);

//Setup Socket.IO
io = io.listen(server);
io.sockets.on('connection', function (socket) {
  console.log('Client Connected');
  socket.on('message', function (data) {
    socket.broadcast.emit('server_message', data);
    socket.emit('server_message', data);
  });
  socket.on('disconnect', function () {
    console.log('Client Disconnected.');
  });
});


///////////////////////////////////////////
//              Routes                   //
///////////////////////////////////////////

/////// ADD ALL YOUR ROUTES HERE  /////////

server.get('/', function (req, res) {
  res.render('index.jade', {
    locals: {
      title: 'Haushaltsbuch', description: 'Unser neues Haushaltsbuch', author: 'Michel Vielmetter'
    }
  });
});


//A Route for Creating a 500 Error (Useful to keep around)
server.get('/500', function (req, res) {
  throw new Error('This is a 500 Error');
});

//The 404 Route (ALWAYS Keep this as the last route)
server.get('/*', function (req, res) {
  throw new NotFound;
});

function NotFound (msg) {
  this.name = 'NotFound';
  Error.call(this, msg);
  Error.captureStackTrace(this, arguments.callee);
}


console.log('Listening on http://0.0.0.0:' + port);
