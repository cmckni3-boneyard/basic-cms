rootdir  = "#{process.cwd()}"
appdir   = "#{rootdir}/app"
app      = require './app'
log4js   = require "#{appdir}/lib/logger"
logger   = log4js.getLogger 'server'

# API Routes

# View Routes
index = require './controllers/index'

posts = require './controllers/posts'

app.get '/', posts.list
app.get '/posts/view/:id', posts.view
app.get '/posts/new', posts.new
app.post '/posts/create', posts.create
# app.get '/posts/edit/:id', posts.edit
# app.patch '/posts/update/:id', posts.update

# Index

app.get '/errors', index.errors
app.get '/500', index.serverError
app.get '/502', index.badGateway

# catch errors and respond with 500
app.use (err, req, res, next) ->
  res.status 500

  logger.error "\n"+err.stack

  res.format

    html: ->
      res.render 'errors/500', error: err, stack: err.stack

    json: ->
      res.send error: err.toString(), stack: err.stack

    text: ->
      res.set 'content-type', 'text/plain'
      res.send "500 Internal server error.\n#{err.toString()}\n#{err.stack}"

    default: ->
      res.sendStatus 406

# everything else is a 404
app.use (req, res) ->
  res.status 404

  res.format

    html: ->
      res.render 'errors/404', url: req.url

    json: ->
      res.send error: '404 Not found', url: req.url

    text: ->
      res.set 'content-type', 'text/plain'
      res.send "404 Not found.\nThe requested URL '#{req.url}' was not found on this server."

    default: ->
      res.sendStatus 406
