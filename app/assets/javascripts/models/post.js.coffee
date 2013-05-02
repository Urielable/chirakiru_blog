window.Post = (->
  save = (posty, success_callback, error_callback) ->
    $.post '/posts.json', posty, (response) ->
      success_callback response if typeof(success_callback) is 'function'
    .error ->
      do error_callback if typeof(error_callback) is 'function'

  since = (datetime, success_callback, error_callback) ->
    $.getJSON "/posts/since/#{datetime}.json", (response) ->
      success_callback response, PostView.show if typeof(success_callback) is 'function'
    .error ->
      do error_callback if typeof(error_callback) is 'function'

  save:  save
  since: since
)()

PostView = (->
  show = (post) ->
    """
      <div class="post hide" data-id="#{post._id}" data-date="#{post.publish_date}">
        <a class="post-title" href="/posts/#{post._id}">
          #{post.title}
        </a>
        <div class="post-date">
          por
          <a href="/authors/#{post.author_id}">
            #{post.author}
          </a>
          en
          #{post.publish_date}
        </div>
        <div class="post-body">
          #{post.body}
        </div>
        <div class="post-tags">
          <a href="/categories/123">
            #Ejemplo
          </a>
        </div>
        <hr></hr>
      </div>
    """

  show: show
)()