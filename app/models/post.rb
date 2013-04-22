class Post
  include Mongoid::Document

  # Fields
  field :title       , type: String
  field :body        , type: String
  field :tags        , type: Array
  field :publish_date, type: DateTime
  field :author_id   , type: Moped::BSON::ObjectId

  # Validations
  validates_presence_of :title, message: "can't be blank!"
  validates_presence_of :body, message: "can't be blank!"
  validates_presence_of :tags, message: "can't be blank!"
  validates_presence_of :publish_date, message: "can't be blank!"
  validates_presence_of :author_id, message: "can't be blank!"

  # Callbacks
  before_create :create_new_tags

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

  protected
  def create_new_tags
    self.tags = self.tags.map { |t| Tag.find_or_create_by(tag:t).id }
  end
end
