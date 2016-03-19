module.exports = (grunt) ->
  grunt.registerTask 'db:seed', 'Seeds the database', ->

    appdir = "#{process.cwd()}/app"
    User   = require "#{appdir}/models/user"
    done   = @async()

    User.find().remove (err) ->
      if err then throw err
      users = [
        username: 'admin'
        password: 'p@ssw0rd'
        roles:    ['admin']
      ,
        username: 'user'
        password: 'p@ssw0rd'
        roles:    ['user']
      ]
      User.create users, (err) ->
        if err then throw err
        done()
