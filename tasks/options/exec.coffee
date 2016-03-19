module.exports =
  "curl-head":
    command: (url) ->
      fs = require 'fs'
      nginx_conf_file = "#{process.cwd()}/app/config/nginx.coffee"
      if fs.existsSync nginx_conf_file
        {serverNames} = require nginx_conf_file
        if serverNames and (server = serverNames.split(' ')[0])
          "curl -I http://#{server} >/dev/null 2>&1"
        else
          "echo \"serverNames not set in app/config/nginx.coffee\"; exit 1"
      else
        "echo \"app/config/nginx.coffee doesn't exist\"; exit 1"
