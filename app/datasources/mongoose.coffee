module.exports = mongoose = require 'mongoose'
util = require 'util'

log4js = require '../lib/logger'
logger = log4js.getLogger 'mongoose'

# connect to mongo
mongo_config = require '../config/mongo'
mongoose.connect mongo_config.uri, mongo_config.options, (err) ->
  if err?
    logger.fatal 'unable to connect'
    throw err
  else
    logger.info 'connected'

mongoose.set 'debug', (collectionName, method, query, doc, options) ->
  logger.debug "#{collectionName}.#{method}(#{util.inspect(query, false, Infinity)})"

mongoose.connection.on 'error', (err) ->
  logger.error err
