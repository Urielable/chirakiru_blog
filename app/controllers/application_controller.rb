class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        if Admin::Author.where(email:username).exists?
          @user = Admin::Author.find_by email:username
          return BCrypt::Password.new(@user.password_digest) == password
        end
      end
    end
end
