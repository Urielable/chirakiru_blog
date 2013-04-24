DashboardMenu = (->
  init = ->
    lis = $('.cbp-vimenu li')
    lis.on 'click', ->
      li = $ @
      lis.removeClass 'cbp-vicurrent'
      li.addClass 'cbp-vicurrent'

      a = li.find 'a'
      href = a.data 'to'
      do $(".container section:not(#{href})").hide
      do $(href).show

  init: init
)()

TextEditor = (->
  init = ->
    opts =
      clientSideStorage: false
      theme:
        base: "/themes/base/epiceditor.css"
        preview: "/themes/preview/github.css"
        editor: "/themes/editor/epic-chirakiru.css"

    window.editor = new EpicEditor(opts).load()

  init: init
)()

TagsEditor = (->
  init = ->
    $('#post-tags').select2 tags:["red", "green", "blue"]

  init: init
)()

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*

Commands = (->
  _preview = null
  _publish = null

  init = ->
    _preview = $ '#preview-post'
    _publish = $ '#publish-post'
    do _add_listener

  _add_listener = ->
    _preview.on 'click', _preview_listener
    _publish.on 'click', _publish_listener

  _preview_listener = ->
    p = do __get_post
    title = escape p['post[title]']
    body  = escape p['post[body]']
    payload  = "post[title]=#{title}&post[body]=#{body}"
    window.open "/admin/dashboard/new?#{payload}"

  _publish_listener = ->
    Post.save do __get_post, (response) ->
      Messenger().post message: "Se publicó la entrada #{response.title}. Ahora todo el mundo podrá leerla. Bien hecho. :)"
    , -> Messenger().post message: "Rayos, algo salió mal. Lo repararemos de inmediato.", type: 'error'

  __get_tag = ->
    $(".select2-search-choice div").map -> @textContent

  __get_post = ->
    post =
      'post[title]' : do $('#post-title').val || 'Sin título'
      'post[body]'  : do editor.exportFile
      'post[tags]'  : do __get_tag().toArray

  init: init
)()

$(document).on 'ready page:load', ->
  if /admin\/dashboard\/?$/.test(window.location.pathname)
    do DashboardMenu.init
    do TextEditor.init
    do TagsEditor.init
    do Commands.init
