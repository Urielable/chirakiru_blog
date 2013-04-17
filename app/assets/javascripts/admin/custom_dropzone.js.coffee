CustomDropzone = (->
  init = ->
    myDropzone = Dropzone.forElement '.dropzone'
    myDropzone.on 'addedfile', (file) ->
      msg = "Se guardó exitosamente el archivo #{file.name}."
      Messenger().post message: msg
    myDropzone.on 'drop', (event) ->
      do myDropzone.removeAllFiles

  init: init
)()

$(document).on 'ready', ->
  if /admin\/dashboard\/?$/.test(window.location.pathname)
    setTimeout CustomDropzone.init, 500

$(document).on 'page:load', ->
  if /admin\/dashboard\/?$/.test(window.location.pathname)
    do jQuery('.dropzone').dropzone
    do CustomDropzone.init
