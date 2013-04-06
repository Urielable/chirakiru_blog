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
      theme:
        base: "/themes/base/epiceditor.css"
        preview: "/themes/preview/github.css"
        editor: "/themes/editor/epic-chirakiru.css"

    window.editor = new EpicEditor(opts).load()

  init: init
)()

$(document).on 'ready page:load', ->
  if /admin\/dashboard/.test(window.location.pathname)
    do DashboardMenu.init
    do TextEditor.init
