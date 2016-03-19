# compile coffeescript files
module.exports =
  glob_to_multiple:
    expand: true
    cwd: 'assets/scripts/'
    src: ['**/*.coffee']
    dest: 'tmp/coffee_output/'
    ext: '.js'
