class Tag
  include Mongoid::Document

  # Fields

  # Validations

  # Callbacks

  def tag
    self.title.unpack('C*').pack('U*')
  end

end
