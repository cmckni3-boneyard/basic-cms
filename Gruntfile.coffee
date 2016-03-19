_loadConfig = (path) ->
  glob = require 'glob'

  object = {}

  glob.sync('*', {cwd: path}).forEach (option) ->
    key = option.replace(/\.coffee$/,'')
    object[key] = require(path + option)

  return object

module.exports = (grunt) ->
  config = {}

  # Loads configs from each file in tasks/options/ into config object
  grunt.util._.extend(config, _loadConfig('./tasks/options/'))

  grunt.initConfig config

  # Loads tasks from tasks/ folder
  grunt.loadTasks 'tasks'

  # Imports & loads grunt tasks from package.json
  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'deploy-assets', [
    'clean:pre'
    'copy'
    'less'
    'postcss'
    'coffee'
    'concat'
    'jade'
    'clean:post'
  ]

  grunt.registerTask 'setup', [
    'shell:copyConfigs'
  ]

  grunt.registerTask 'default', [
    'deploy-assets'
    'concurrent:dev'
  ]

  grunt.registerTask 'compile-assets', [
    'deploy-assets'
    'uglify'
  ]

  grunt.registerTask 'production', [
    'compile-assets'
    'touch:restart'
    'exec:curl-head'
  ]
