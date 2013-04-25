BottomScroller = (->
  init = ->
    $(window).scroll ->        
      if $(window).scrollTop() + $(window).height() >= $(document).height()
        do MySpinner.on
        console.log 'Hola'
      else
        do MySpinner.off

  init: init
)()

$(document).on 'ready page:load', ->
  do BottomScroller.init
