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
        console.log err
        res.redirect '/user/new'

      res.json user

  ###*
  * Overrides for the settings in `config/controllers.js`
  * (specific to UserController)
  ###
  _config: {}
