MySpinner = (->
  spinner = null
  target  = null

  _on = ->
    opts =
      lines: 11 # The number of lines to draw
      length: 10 # The length of each line
      width: 6 # The line thickness
      radius: 13 # The radius of the inner circle
      corners: 1 # Corner roundness (0..1)
      rotate: 0 # The rotation offset
      direction: 1 # 1: clockwise, -1: counterclockwise
      speed: 1 # Rounds per second
      color: 'rgb(205, 205, 205)'
      trail: 60 # Afterglow percentage
      shadow: false # Whether to render a shadow
      hwaccel: true # Whether to use hardware acceleration
      className: "spinner" # The CSS class to assign to the spinner
      zIndex: 2e9 # The z-index (defaults to 2000000000)
      top: "auto" # Top position relative to parent in px
      left: "auto" # Left position relative to parent in px

    target = document.getElementById 'bottom-spinner'
    if target?
      $(target).css 'opacity', 1
    else
      target = document.getElementById 'bottom-spinner'
    spinner = new Spinner(opts).spin target

  _off = ->
    if spinner?
      do spinner.stop
      $(target).css 'opacity', 0

  on: _on
  off: _off
)()
window.MySpinner = MySpinner
