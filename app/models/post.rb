class Post
  include Mongoid::Document

  # Fields

  # Validations

  # Callbacks

  def ptitle
    self.title.unpack('C*').pack('U*')
  end

  def ptags
    self.tags.unpack('C*').pack('U*')
  end

  def content
    b = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true).render(self.body)
    b.unpack('C*').pack('U*').gsub '&amp;mdash;', '&mdash;'
  end
end
