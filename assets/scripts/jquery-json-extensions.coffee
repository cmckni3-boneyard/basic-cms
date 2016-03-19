(($) ->

  $.postJSON = (url, params) ->
    $.ajax
      contentType: 'application/json'
      data: JSON.stringify params
      dataType: 'json'
      type: 'POST'
      url: url

  $.patchJSON = (url, params) ->
    $.ajax
      contentType: 'application/json'
      data: JSON.stringify params
      dataType: 'json'
      type: 'PATCH'
      url: url
  $.delete = (url) ->
    $.ajax
      contentType: 'application/json'
      dataType: 'json'
      type: 'DELETE'
      url: url

) jQuery
