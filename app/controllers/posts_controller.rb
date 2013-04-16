class PostsController < ApplicationController
  def index
  end

  # POST /posts
  # POST /posts.json
  def create
  	params[:post][:author_id] = current_user.id
  	params[:post][:post_date] = Time.new
  	@post = Post.new(params[:post])
  	@post.author_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'El Postxxº fue guardado exitosamente.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
end
