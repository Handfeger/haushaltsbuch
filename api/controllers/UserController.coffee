###*
* UserController
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
util = require 'util'

module.exports =
  ###*
  * Action for a new user
  ###
  new: (req, res) ->
    res.view()

  ###*
  * Action to create a user
  ###
  create: (req, res, next) ->
    User.create req.params.all(), (err, user) ->
      if err
        console.log util.inspect err, false, null
        req.session.flash = err: err
        res.redirect '/user/new'

      res.redirect "/user/show/#{user.id}"

  show: (req, res, next) ->
    User.findOne req.param('id'), (err, user) ->
      if err
        console.log util.inspect err, false, null
        return next err

      if not user
        return next()

      res.view user: user

  edit: (req, res, next) ->
    User.findOne req.param('id'), (err, user) ->
      if err
        console.log util.inspect err, false, null
        return next err

      if not user
        return next 'Kein Nutzer gefunden'

      res.view user: user

  update: (req, res, next) ->
    User.update req.param('id'), req.params.all(), (err, user) ->
      if err or not user
        console.log util.inspect err, false, null
        return res.redirect "/user/edit/#{req.param('id')}"

      res.redirect "/user/show/#{req.param('id')}"





  index: (req, res, next) ->
    User.find (err, users) ->
      if err
        console.log util.inspect err, false, null
        return next err

      res.view users: users


  destroy: (req, res, next) ->
    console.log req.method
    return next 'User können nur mit Buttons gelöscht werden!' if req.method isnt 'DELETE'
    User.findOne req.param('id'), (err, user) ->
      if err
        console.log util.inspect err, false, null
        return next err

      if not user
        return next 'Kein Nutzer gefunden'

      User.destroy req.param('id'), (err) ->
        if err
          console.log util.inspect err, false, null
          return next err

      res.redirect '/user'

  _config: {}
