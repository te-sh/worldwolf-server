class GamesController < ApplicationController
  def create
    game = Game.new(create_params)
    raise Forbidden unless game.creator == @user || !@user.active || @user.room.game

    if game.save
      render json: game.as_json(Game::JSON)
    else
      head :bad_request
    end
  end

  def update
    game = Game.find(params[:id])
    raise Forbidden unless game.creator == @user

    if game.update_attributes(update_params)
      render json: game.as_json(Game::JSON)
    else
      head :bad_request
    end
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    head :ok
  end

  private

  def create_params
    params.require(:game).permit(:room_id, :creator_id)
  end

  def update_params
    params.require(:game).permit(
      :normal_word,
      :wolf_word,
      game_wolves_attributes: [:wolf_id]
    )
  end
end
