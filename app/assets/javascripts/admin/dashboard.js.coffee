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
    console.log p
    payload  = "post[title]=#{p.title}&post[body]=#{p.body}&post[tags]=#{p.tags}"
    window.open "/admin/dashboard/new?#{payload}"

  _publish_listener = ->
    Post.save do __get_post
    false

  __get_post = ->
    post = 
      'post[title]'     : escape do $('#post-title').val || 'Sin título'
      'post[body]'      : escape do editor.exportFile
      'post[tags]'      : escape do $('#post-tags').val || 'Java sucks!'

  init: init
)()

$(document).on 'ready page:load', ->
  if /admin\/dashboard\/?$/.test(window.location.pathname)
    do DashboardMenu.init
    do TextEditor.init
    do Commands.init
