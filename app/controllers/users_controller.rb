class UsersController < ApplicationController
  skip_before_action :set_user, only: :create

  def show_mine
    render json: @user.as_json(User::JSON)
  end

  def destroy_mine
    raise Forbidden if @user.active && @user.room.game
    @user.destroy
    session.clear
    head :ok
  end

  def create
    user = User.create_with_pass(params[:room_id], params[:name], params[:pass])

    if user
      session[:user] = user.id
      render json: user.as_json(User::JSON)
    else
      head :bad_request
    end
  end

  def update
    user = User.find(params[:id])
    raise Forbidden if user.room.game

    if user.update_attributes(update_params)
      render json: user.as_json(User::JSON)
    else
      head :bad_request
    end
  end

  private

  def update_params
    params.require(:user).permit(:active)
  end
end
