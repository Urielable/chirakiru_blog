class PostsController < ApplicationController
  include PostsHelper

  def index
  end

  # POST /posts
  # POST /posts.json
  def create
    #
    #"post"=>{"title"=>"Coso%20coso", "body"=>"coso", 
    #"tags"=>["green", "csadsa.cad", "cacdad"], "post_date"=>2013-04-20 22:46:17 -0500}, 
    #"action"=>"create", "controller"=>"posts", "format"=>"json"}
    params[:post][:post_date] = Time.new
    params[:post][:author_id] = current_user.id

    @post = Post.new(params[:post])
    @post.tags = get_tags_id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'El Post fue guardado exitosamente.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
end
