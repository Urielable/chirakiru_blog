class Admin::DashboardController < ApplicationController
  def index
  end

  def new
    @post = Post.new params[:post]
  end
end
