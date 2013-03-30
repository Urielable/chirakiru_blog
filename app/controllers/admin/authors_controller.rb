class Admin::AuthorsController < ApplicationController
  before_filter :authenticate

  # GET /admin/authors
  # GET /admin/authors.json
  def index
    @admin_authors = Admin::Author.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_authors }
    end
  end

  # GET /admin/authors/1
  # GET /admin/authors/1.json
  def show
    @admin_author = Admin::Author.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_author }
    end
  end

  # GET /admin/authors/new
  # GET /admin/authors/new.json
  def new
    @admin_author = Admin::Author.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_author }
    end
  end

  # GET /admin/authors/1/edit
  def edit
    @admin_author = Admin::Author.find(params[:id])
  end

  # POST /admin/authors
  # POST /admin/authors.json
  def create
    @admin_author = Admin::Author.new(params[:admin_author])
    @admin_author.password_digest = 

    respond_to do |format|
      if @admin_author.save
        format.html { redirect_to @admin_author, notice: 'Author was successfully created.' }
        format.json { render json: @admin_author, status: :created, location: @admin_author }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/authors/1
  # PUT /admin/authors/1.json
  def update
    @admin_author = Admin::Author.find(params[:id])

    respond_to do |format|
      if @admin_author.update_attributes(params[:admin_author])
        format.html { redirect_to @admin_author, notice: 'Author was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/authors/1
  # DELETE /admin/authors/1.json
  def destroy
    @admin_author = Admin::Author.find(params[:id])
    @admin_author.destroy

    respond_to do |format|
      format.html { redirect_to admin_authors_url }
      format.json { head :no_content }
    end
  end
end
