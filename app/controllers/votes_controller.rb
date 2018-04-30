class VotesController < ApplicationController
  def index
    game = Game.find(params[:game_id])
    raise Forbidden unless game.creator == @user

    render json: game.votes.as_json(Vote::JSON)
  end

  def create
    vote = select_or_create
    raise Forbidden unless vote.voter == @user

    if vote.save
      render json: vote.as_json(Vote::JSON)
    else
      head :bad_request
    end
  end

  private

  def select_or_create
    vote = Vote.where(game_id: @user.room.game, voter_id: @user.id).first

    if vote
      vote.attributes = create_params
    else
      vote = Vote.new(create_params)
    end

    vote
  end

  def create_params
    params.require(:vote).permit(:game_id, :voter_id, :votee_id)
  end
end
