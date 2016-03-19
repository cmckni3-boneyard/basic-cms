module.exports =
  options:
      map: true
      processors: [
        require('autoprefixer-core')({browsers: 'last 1 version'}).postcss
      ]
    dist:
      src: 'tmp/less_output/*.css'
