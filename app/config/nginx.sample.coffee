config = require './app'

module.exports =
  upstreamName: config.appName
  publicRoot: "/home/#{config.appUser}/sites/#{config.appName}/public"
  # space separated list of server names for nginx vhost
  serverNames: config.appName
  confPath: '/etc/nginx/sites-available'
