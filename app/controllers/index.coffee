# get /errors
errors = (req, res, next) ->
  res.render 'errors'

# get /500
serverError = (req, res, next) ->
  next new Error 'A wild error appears!'

# get /502
badGateway = (req, res, next) ->
  res.render 'errors/502'

module.exports =
  errors: errors
  serverError: serverError
  badGateway: badGateway
