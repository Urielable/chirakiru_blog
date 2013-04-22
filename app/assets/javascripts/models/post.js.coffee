window.Post = (->
  save = (posty, success_callback, error_callback) ->
    $.post '/posts.json', posty, (response) ->
      success_callback response if typeof(success_callback) is 'function'
    .error ->
      do error_callback if typeof(error_callback) is 'function'

  save: save
)()
