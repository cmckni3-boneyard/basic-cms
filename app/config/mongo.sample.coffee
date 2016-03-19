{appName} = require('./app')

module.exports =
  uri: "mongodb://localhost/#{appName}"
  options:
    server:
      poolSize: 5
