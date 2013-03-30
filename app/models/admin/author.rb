require 'bcrypt'

class Admin::Author
  include Mongoid::Document

  # Fields
  field :first_name, type: String
  field :last_name, type: String
  field :nickname, type: String
  field :acronym, type: String
  field :email, type: String
  field :password_digest, type: String
  field :remember_token, type: String

  # Validations
  validates_presence_of :first_name, message: "can't be blank!"
  validates_presence_of :last_name, message: "can't be blank!"
  validates_presence_of :nickname, message: "can't be blank!"
  validates_presence_of :acronym, message: "can't be blank!"
  validates_presence_of :email, message: "can't be blank!"
  validates_presence_of :password_digest, message: "can't be blank!"

  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of :email, with: VALID_EMAIL_REGEX

  # Callbacks
  before_create :create_remember_token

  def password= new_password
    self.password_digest = BCrypt::Password.create new_password
  end

  protected
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
