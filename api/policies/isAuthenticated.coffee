###*
 * isAuthenticated
 *
 * @module      :: Policy
 * @description :: Simple policy to allow any authenticated user
 *                 Assumes that your login action in one of your controllers sets `req.session.authenticated = true;`
 * @docs        :: http://sailsjs.org/#!documentation/policies
*
###
module.exports = (req, res, ok) ->

  # User is allowed, proceed to the next policy,
  # or if this is the last policy, the controller
  console.log req.session.authenticated
  return ok() if req.session.authenticated

  return ok() if req.action is 'signin' and req.controller is 'session'

  # User is not allowed
  # (default res.forbidden() behavior can be overridden in `config/403.js`)
  req.session.flash = [
    {
      name:    'loginForced'
      message: 'Bitte anmelden!'
    }
  ]
  res.redirect '/session/signin'