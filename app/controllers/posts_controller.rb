class PostsController < ApplicationController
  include PostsHelper

  def index
  end

  # POST /posts.json
  # "post"=>{"title"=>"Greetings", "body"=>"Hello!", "tags"=>["green", "red"]}
  def create
    params[:post][:publish_date] = Time.now
    params[:post][:author_id] = current_user.id
    #@post.tags = get_tags_id
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.json { render json: @post, status: :created, location: @post }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
end
