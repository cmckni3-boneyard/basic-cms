# clean up compiled or temporary files
module.exports =
  pre: ['public/*']
  pre_images: ['public/img/*']
  post: ['tmp/*', '!tmp/restart.txt']
