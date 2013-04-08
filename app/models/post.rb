class Post
  include Mongoid::Document

  # Fields

  # Validations

  # Callbacks

  def content
    b = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true).render(self.body)
    b.gsub '&amp;mdash;', '&mdash;'
  end
end
