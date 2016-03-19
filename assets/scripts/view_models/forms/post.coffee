class @PostFormView

  serialize: ->
    title: @title()
    content: @content()

  blank_post:
    title: ''
    content: ''

  constructor: ->
    @title = ko.observable(@blank_post.title)
    @content = ko.observable(@blank_post.content)

    $('.cloak').removeClass('cloak')

    ko.applyBindings @

  save: ->
    req = $.postJSON '/posts/create', @serialize()
    req.done (post) ->
      if post.error?
        errorMessage 'Failed to create new post'
      else
        successMessage "Post created"
        window.location = '/'
