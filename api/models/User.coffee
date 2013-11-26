###*
* User
*
* @module      :: Model
* @description :: A short summary of how this model works and what it represents.
* @docs		:: http://sailsjs.org/#!documentation/models
###
module.exports =
  schema: true

  attributes:
    name:
      type: 'string'
      required: true

    email:
      type: 'string'
      required: true
      email: true
      unique: true

    encryptedPassword:
      type: 'string'

    toJSON: () ->
      obj = @toObject()
      delete obj.password
      delete obj.confirmation
      delete obj.encryptedPassword
      delete obj._csrf

      return obj
