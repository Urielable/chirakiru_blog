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

  init = ->
    _preview = $ '#preview-post'
    do _add_listener

  _add_listener = ->
    _preview.on 'click', _preview_listener

  _preview_listener = ->
    title = escape do $('#post-title').val || 'Sin título'
    body  = escape do editor.exportFile
    tags  = escape do $('#post-tags').val || 'Java sucks!'
    post  = "post[title]=#{title}&post[body]=#{body}&post[tags]=#{tags}"
    window.open "/admin/dashboard/new?#{post}"

  init: init
)()

$(document).on 'ready page:load', ->
  if /admin\/dashboard\/?$/.test(window.location.pathname)
    do DashboardMenu.init
    do TextEditor.init
    do Commands.init
