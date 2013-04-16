$(document).on 'ready page:load', ->
  setTimeout ->
    myDropzone = Dropzone.forElement '.dropzone'
    myDropzone.on 'addedfile', (file) ->
      msg = "Se guardó exitosamente el archivo #{file.name}."
      Messenger().post message: msg
    myDropzone.on 'drop', (event) ->
      do myDropzone.removeAllFiles
  , 1000
