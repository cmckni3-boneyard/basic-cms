start = new Date

require 'sugar'
require './lib/process'

fs = require 'fs'

log4js = require './lib/logger'
logger = log4js.getLogger 'server'

config = require './config/app'

if config.socket? then require './lib/socket'

# create and configure the express app
app = require './lib/express'
env = app.settings.env

# create the http server
server = require('http').createServer app

# delete the socket file if it exists (from a previous crash)
if config.socket? and fs.existsSync config.socket
  fs.unlinkSync config.socket

# start server
server.listen app.settings.port, ->
  if config.socket? and fs.existsSync config.socket
    fs.chmodSync config.socket, '777'

  portType = if config.socket? then 'socket' else 'port'
  time = new Date - start
  logger.info "#{config.appName} started#{if port = app.settings.port then " on #{portType} #{port}" else ''} (#{env} mode) in #{time}ms"

module.exports = app
