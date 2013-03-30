class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery

  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        @user = Admin::Author.find_by email:username
        if @user
          return BCrypt::Password.new(@user.password_digest) == password
        end
      end
    end
end
