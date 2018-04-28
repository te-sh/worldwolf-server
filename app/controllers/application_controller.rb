class ApplicationController < ActionController::API
  before_action :set_user

  rescue_from Forbidden, with: :forbidden

  def set_user
    throw :abort unless session[:user]
    @user = User.find(session[:user])
  rescue ActiveRecord::RecordNotFound
    throw :abort
  end

  def forbidden
    head :forbidden
  end
end
