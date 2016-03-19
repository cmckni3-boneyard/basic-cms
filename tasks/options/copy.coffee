# copy static assets into public/
module.exports =
  images:
    expand: true
    flatten: true
    src: ['assets/img/**', 'bower_components/immybox/**/*.png']
    dest: 'public/img/'
  fontAwesome:
    expand: true
    cwd: 'bower_components/font-awesome/fonts/'
    src: '*'
    dest: 'public/fonts/'
  glyphIcons:
    expand: true
    cwd: 'bower_components/bootstrap/fonts/'
    src: '*'
    dest: 'public/fonts/'
