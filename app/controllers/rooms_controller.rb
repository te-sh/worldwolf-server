class RoomsController < ApplicationController
  skip_before_action :set_user, only: :index

  def index
    rooms = Room.order(:order).all
    render json: rooms.as_json(Room::JSON_LIST)
  end

  def show
    room = Room.includes(:users).find(params[:id])
    raise Forbidden unless room.users.include?(@user)
    render json: room.as_json(Room::JSON_DETAIL)
  end
end
