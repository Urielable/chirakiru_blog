class Post  
  include Mongoid::Document
  include TimeHelper

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

  def tags_related
    Tag.find self.tags
  end

  def author
    Admin::Author.find self.author_id
  end

  def content
    b = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true).render(self.body)
    b.gsub '&amp;mdash;', '&mdash;'
  end

  def superpower!
    @author = self.author
    {
      _id: self.id,
      publish_date: self.publish_date,
      pretty_date: self.publish_date.pretty,
      title: self.title,
      author_id: @author._id,
      author: @author.first_name,
      content: self.content
    }
  end

  protected
  def create_new_tags
    self.tags = self.tags.map { |t| Tag.find_or_create_by(tag:t).id }
  end
end
