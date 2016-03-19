module.exports =
  scripts:
    files: ['assets/scripts/**/*.coffee']
    tasks: ['coffee', 'concat:app_js', 'clean:post']

  styles:
    files: ['assets/styles/**/*.less']
    tasks: ['less', 'postcss', 'concat:app_css', 'clean:post']

  images:
    files: ['assets/img/**']
    tasks: ['clean:pre_images', 'copy:images']

  badGateway:
    files: ['app/views/errors/502.jade']
    tasks: ['jade']

  templates:
    files: ['app/views/**']
    options: livereload: true

  livereload:
    files: ['public/**/*']
    options: livereload: true

  gruntfile:
    files: ['Gruntfile.coffee', 'tasks/**/*.coffee']
    tasks: ['deploy-assets']

  npm:
    files: ['package.json']
    tasks: ['shell:npm']

  bower:
    files: ['bower.json']
    tasks: ['shell:bower']
