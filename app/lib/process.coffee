log4js = require '../lib/logger'
logger = log4js.getLogger 'process'

process.on 'uncaughtException', (err) ->
  logger.fatal "Uncaught Exception [#{err.toString()}]\n#{err.stack}"
  process.emit 'cleanup'
  setTimeout ->
    process.exit 1
  , 500

process.on 'SIGTERM', ->
  logger.info 'caught SIGTERM'
  process.emit 'cleanup'
  setTimeout ->
    process.exit 0
  , 500

process.on 'SIGINT', ->
  logger.info 'caught SIGINT'
  process.emit 'cleanup'
  setTimeout ->
    process.exit 0
  , 500

process.on 'cleanup', ->
  logger.info 'cleanup signal detected, exiting in .5 seconds...'
