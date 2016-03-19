rootdir        = "#{process.cwd()}"
appdir         = "#{rootdir}/app"

express        = require 'express'
favicon        = require 'serve-favicon'
compress       = require 'compression'
bodyParser     = require 'body-parser'
methodOverride = require 'method-override'
cookieParser   = require 'cookie-parser'
activeTags     = require 'active-tags'

conf           = require "#{appdir}/config/app"
mongo_conf     = require "#{appdir}/config/mongo"

log4js         = require "#{appdir}/lib/logger"
logger         = log4js.getLogger 'server'

module.exports = app = express()

app.set 'env', conf.env
app.set 'port', if conf.socket? then conf.socket else conf.port
app.set 'views', "#{appdir}/views"
app.set 'view engine', 'jade'

app.use log4js.connectLogger logger, level: 'auto', format: ':method :url :status - :response-time ms'
app.use express.static "#{rootdir}/public"
app.use favicon "#{rootdir}/assets/img/favicon.ico"
app.use compress()
app.use bodyParser.urlencoded(extended: false)
app.use bodyParser.json()
app.use methodOverride()
app.use cookieParser()
app.use (req, res, next) -> res.locals.conf = conf; next()
app.use activeTags()
