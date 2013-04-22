class Tag
  include Mongoid::Document

  # Fields
  field :tag, type: String

  # Validations
  validates_presence_of :tag, message: "can't be blank!"

  # Callbacks
end
