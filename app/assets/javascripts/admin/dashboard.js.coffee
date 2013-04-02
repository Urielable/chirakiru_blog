DashboardMenu = (->
  init = ->
    lis = $('ul.cbp-vimenu li')
    lis.on 'click', ->
      li = $ @
      lis.removeClass 'cbp-vicurrent'
      li.addClass 'cbp-vicurrent'

    anchors = lis.find 'a'
    anchors.on 'click', ->
      a = $ @
      href = a.data 'to'
      do $(".container div:not(#{href})").hide
      do $(href).show
      false
  
  init: init
)()

$(document).on 'ready page:load', DashboardMenu.init
