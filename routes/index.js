/*
 * GET home page.
 */

exports.index = function (req, res) {
  var loggedIn = false;
  var title = loggedIn ? 'Haushaltsbuch' : 'Einloggen';
  var error = req.session.error || false;

  req.session.error = false;

  res.render('index', {
    title   : title,
    loggedIn: loggedIn,
    error   : error
  });
};

exports.login = function (req, res) {
  req.session.error = true;

  var user = req.getParameter('user');
  var password = req.getParameter('password');

  console.log(user, password);


  res.redirect('/');
};