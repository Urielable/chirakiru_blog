class PostsController < ApplicationController
  def index
    @posts = Post.all.desc :publish_date
  end

  # GET /admin/post/1
  # GET /admin/post/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end


  # POST /posts.json
  # "post"=>{"title"=>"Greetings", "body"=>"Hello!", "tags"=>["green", "red"]}
  def create
    params[:post][:publish_date] = Time.now
    params[:post][:author_id] = current_user.id
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
