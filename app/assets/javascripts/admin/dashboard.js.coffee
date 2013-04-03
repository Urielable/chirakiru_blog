DashboardMenu = (->
  init = ->
    lis = $('.cbp-vimenu li')
    lis.on 'click', ->
      li = $ @
      lis.removeClass 'cbp-vicurrent'
      li.addClass 'cbp-vicurrent'

      a = li.find 'a'
      href = a.data 'to'
      do $(".container div:not(#{href})").hide
      do $(href).show
  
  init: init
)()

$(document).on 'ready page:load', DashboardMenu.init
