class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :set_user

  rescue_from Forbidden, with: :forbidden

  def set_user
    authenticate_or_request_with_http_token do |token, _options|
      @user = User.find_by(token: token)
      @user.present?
    end
  end

  def forbidden
    head :forbidden
  end
end
