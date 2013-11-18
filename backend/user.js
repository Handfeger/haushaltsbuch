var mongoose = require('mongoose');


var User = function () {
  this.loggedIn = false;
}

User.prototype.loginWithCredentials = function (user, password) {
  this.loggedIn = user === 'michel';

  return this.loggedIn;
}

module.exports = function () {
  return new User();
};