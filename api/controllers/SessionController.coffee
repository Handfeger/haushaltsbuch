###*
 * SessionController
 *
 * @module      :: Controller
 * @description	:: A set of functions called `actions`.
 *
 *                 Actions contain code telling Sails how to respond to a certain type of request.
 *                 (i.e. do stuff, then send some JSON, show an HTML page, or redirect to another URL)
 *
 *                 You can configure the blueprint URLs which trigger these actions (`config/controllers.js`)
 *                 and/or override them with custom routes (`config/routes.js`)
 *
 *                 NOTE: The code you write here supports both HTTP and Socket.io automatically.
 *
 * @docs        :: http://sailsjs.org/#!documentation/controllers
###

bcrypt = require 'bcrypt'

module.exports =

  signin: (req, res) ->
    res.view('session/signin')

  create: (req, res) ->
    # Check for values
    if not req.param('email') or not req.param('password')
      req.session.flash =
        err: [
          {
            name:    'usernamePasswordRequired'
            message: 'Bitte alle Felder zum anmelden ausfüllen!'
          }
        ]

      res.redirect('/session/signin')
      return;

    User.findOneByEmail(req.param('email')).done (err, user) ->
      return next err if err

      #User not found
      if not user
        req.session.flash =
          err: [
            {
              name:    'userNotFound'
              message: 'Dieser User wurde nicht gefunden'
            }
          ]

        res.redirect('/session/signin')
        return

      bcrypt.compare req.param('password'), user.encryptedPassword, (err, valid) ->
        return next err if err

        if not valid
          req.session.flash =
            err: [
              {
                name:    'wrongPassword'
                message: 'Bitte geben sie das korrekte Passwort ein'
              }
            ]

          res.redirect('/session/signin')
          return

        req.session.authenticated = true
        req.session.User = user

        res.redirect('/')

  logout: (req, res) ->
    req.session.destroy()
    req.session.flash =
      err: [
        {
          name:    'successfulLogout'
          message: 'Sie wurder ausgeloggt'
        }
      ]
    res.redirect('/session/signin')

  _config: {}