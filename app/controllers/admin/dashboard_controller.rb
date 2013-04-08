class Admin::DashboardController < ApplicationController
  def index
  end

  def new
    @post = params[:post]
    body = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true).render(@post[:body])
    @post[:body] = body.gsub '&amp;mdash;', '&mdash;'
  end
end
