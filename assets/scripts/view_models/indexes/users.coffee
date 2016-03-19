class User

  constructor: (@view, user) ->
    @_id        = user._id
    @username   = user.username
    @role       = user.role

    @editUrl    = ko.computed => "/users/#{@_id}"

  del: ->
    bootbox.confirm 'Are you sure you want to permenantly delete this user?', (confirmed) =>
      if confirmed
        req = $.delete "/api/users/#{@_id}/delete_user"
        req.done (response) =>
          if response?.error?
            errorMessage 'Unable to delete user.'
          else
            successMessage "User deleted."
            @view.table.rows.remove @


class @UsersView

  constructor: ->
    @table = new DataTable [], {
      recordWord: 'user'
      sortDir: 'asc'
      sortField: 'name'
      perPage: 50
    }

    @table.loading true

    req = $.getJSON '/api/users'

    req.done (users) =>
      if users.error?
        errorMessage 'Unable to retrieve users.'
      else
        @table.rows users.map (user) => new User @, user
        @table.loading false

    ko.applyBindings @, document.getElementById('main')
