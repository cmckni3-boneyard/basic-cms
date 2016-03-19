module.exports =
  copyConfigs:
    options:
      stdout: true
      stderr: true
    command: """
      cp app/config/app.sample.coffee app/config/app.coffee
      cp app/config/logger.sample.coffee app/config/logger.coffee
      cp app/config/mongo.sample.coffee app/config/mongo.coffee
      cp app/config/nginx.sample.coffee app/config/nginx.coffee
    """
  # this task must be run as root
  activateService:
    options:
      stdout: true
      stderr: true
    command: if config? then "chkconfig #{config.appName} on" else "echo 'no config file'"
  npm:
    options:
      stdout: true
      stderr: true
    command: 'npm prune && npm install'
  bower:
    options:
      stdout: true
      stderr: true
    command: 'bower prune && bower install'
