# compile less files
module.exports =
  app:
    options:
      paths: [
        'bower_components/bootstrap/less'
        'bower_components/font-awesome/less'
        'bower_components/immybox'
      ]
      compress: config?.env is 'production'
    files:
      'tmp/less_output/app.css': 'assets/styles/app.less'
