appdir     = "#{process.cwd()}/app"
ff         = require 'ff'

User = require "#{appdir}/models/user"

# TODO: Implement schema validation

# get /api/users/admins
listAdmins = (req, res, next) ->
  User.where(role: 'admin').find (err, admins) ->
    if err then return next err
    res.send admins

# get /api/users
listUsers = (req, res, next) ->
  User.find (err, users) ->
    if err then return next err
    res.send users

# get /api/users/:id
showUser = (req, res, next) ->
  User.findById req.params.id, (err, user) ->
    if err then return next err
    if not user? then return next()
    res.send user

# post /api/users/create_user
createUser = (req, res, next) ->
  User.isUsernameAvailable req.body.username, (err, available) ->
    if err then return next err
    if not available then return next invalid_message: "Username already taken"
    User.create req.body, (err, user) ->
      if err then return next err
      res.status 201
      res.send user

# patch /api/users/:id/update_user
updateUser = (req, res, next) ->
  (f= ff()).next ->
    User.findById req.params.id, f.slot()

  f.next (user) ->
    f.pass user
    if not user? then return f.fail(404)
    if 'undefined' isnt typeof req.body.username and user.username isnt req.body.username
      User.isUsernameAvailable req.body.username, f.slot()
    else
      f.pass(true)

  f.next (user, available) ->
    if available
      user.applyUpdates req.body, f.slot()
    else
      f.fail invalid_message: 'Username already taken'

  f.onSuccess (user) ->
    res.send user

  f.onError (err) ->
    if err is 404
      next()
    else
      next err

# delete /api/users/:id/delete_user
deleteUser = (req, res, next) ->
  User.findById req.params.id, (err, user) ->
    if err then return next err
    if not user? then return next()
    user.remove (err) ->
      if err then return next err
      res.sendStatus 204

module.exports =
  listAdmins: [listAdmins]
  listUsers:  [listUsers]
  showUser:   [showUser]
  createUser: [createUser]
  updateUser: [updateUser]
  deleteUser: [deleteUser]
