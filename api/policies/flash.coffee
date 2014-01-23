module.exports = (req, res, next) ->
  res.locals.flash = {}

  return next() if not req.session.flash

  res.locals.flash = _.clone req.session.falsh
  req.session.flash = {}

  next()