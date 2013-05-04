BottomScroller = (->
  init = ->
    last = null
    $(window).off('scroll').on 'scroll', ->
      if $(window).scrollTop() + $(window).height() >= $(document).height()
        return false if new Date() - last < 500
        do bottom
        last = new Date()

  bottom = ->
    Post.since $('.post:last').data('date'), (posts, view) ->
      if posts.length > 0
        $(view(post)).insertBefore('#bottom-spinner') for post in posts
        $("[data-id=#{post._id}]").fadeIn(1000) for post in posts
      else
        Messenger().post message: '¡Wow! Has leído todas las publicaciones de Chirakiru Puroguramingu. ¡Muchas gracias!', id: 'unique'
        $('#bottom-spinner i').removeClass('icon-arrow-down').addClass('icon-arrow-up')
        do RabbitSpinner.on

  init: init
)()

$(document).on 'ready page:load', ->
  do BottomScroller.init
