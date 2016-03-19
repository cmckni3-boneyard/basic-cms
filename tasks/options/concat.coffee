# concatenate js files
module.exports =
  options:
    separator: ';'
  compat_js:
    src: [
      'bower_components/modernizr/modernizr.js'
      'bower_components/respond/dest/respond.src.js'
      'bower_components/es5-shim/es5-shim.js'
    ]
    dest: 'public/js/compat.js'
  app_js:
    src: [
      'bower_components/sugar/release/sugar.min.js'
      'bower_components/jquery/dist/jquery.js'
      'bower_components/bootstrap/dist/js/bootstrap.js'
      'bower_components/knockout.js/knockout.js'
      'bower_components/knockout-datatable/knockout-datatable.min.js'
      'bower_components/immybox/jquery.immybox.min.js'
      'bower_components/immybox/knockout-immybox.min.js'
      'bower_components/bootbox/bootbox.js'

      'tmp/coffee_output/window-messages.js'
      'tmp/coffee_output/jquery-config.js'
      'tmp/coffee_output/jquery-json-extensions.js'
      'tmp/coffee_output/knockout-extenders.js'
      'tmp/coffee_output/view_models/**/*.js'
    ]
    dest: 'public/js/app.js'
  app_css:
    options:
      separator: '\n'
    src: [
      'tmp/less_output/app.css'
    ]
    dest: 'public/css/app.css'
