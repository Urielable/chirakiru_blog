Sessions = (->
  init = ->
    form = $('form[action$=sessions]')
    form.on 'submit', login

  login = ->
    $.post '/sessions.json', $(@).serialize(), (response) ->
      Turbolinks.visit '/admin/dashboard'
    .error ->
      Messenger().post message: 'Lo siento, esta vez no podrás pasar.', type: 'error', id: 'unique'
    false

  init: init
)()

$(document).on 'ready page:load', ->
  if /login/.test(window.location.pathname)
    do Sessions.init
