Post = require '../models/post'

mongoose = require 'mongoose'

log4js = require '../lib/logger'
logger = log4js.getLogger 'server'

# TODO: Validations
listPosts = (req, res) ->
  Post.find {}, (err, posts) ->
    if err? then return next err
    res.render 'posts/index', posts: posts

viewPost = (req, res, next) ->
  id = mongoose.Types.ObjectId(req.params.id)
  Post.findOne {_id: id}, (err, post) ->
    if err? then return next err
    if !post? then return next()
    res.render 'posts/view', post: post

newPost = (req, res) ->
  res.render 'posts/new'

createPost = (req, res, next) ->
  new_post = req.body
  Post.create req.body, (err, post) ->
    if err? then return res.json(success: false, error: err)
    res.json(success: true, error: null)

module.exports =
  list: listPosts
  view: viewPost
  new: newPost
  create: createPost
