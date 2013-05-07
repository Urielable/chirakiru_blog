BottomScroller = (->
  offsets = null
  stats = null
  current_item = null
  total_items = null

  init = ->
    last = null
    stats = $('.reader-stats')
    current_item = stats.find('.current-item')
    total_items = stats.find('.total-items')
    $(window).off('scroll').on 'scroll', ->
      if $(window).scrollTop() + $(window).height() >= $(document).height()
        return false if new Date() - last < 500
        do bottom
        last = new Date()
      else if $(document).width() > 700
        do guide

  bottom = ->
    Post.since $('.post:last').data('date'), (posts, view) ->
      if posts.length > 0
        $(view(post)).insertBefore('#bottom-spinner').fadeIn(1000) for post in posts
      else
        Messenger().post message: '¡Wow! Has leído todas las publicaciones de Chirakiru Puroguramingu. ¡Muchas gracias!', id: 'unique', showCloseButton: true
        $('#bottom-spinner i').removeClass('icon-arrow-down').addClass('icon-arrow-up')
        do RabbitSpinner.on

  guide = ->
    stats.fadeIn 100
    offsets = $('.post').map -> @offsetTop
    scroll = $(document).scrollTop() + 120
    current = _.indexOf(offsets, _.find(offsets, (offset) -> scroll < offset))
    if current >= 0
      current_item.text current + 1
      total_items.text offsets.length

  init: init
)()

$(document).on 'ready page:load', ->
  if /^\/$/.test(window.location.pathname)
    do BottomScroller.init

$(document).on 'page:fetch', ->
  $(window).off('scroll') if !/^\/$/.test(window.location.pathname)
