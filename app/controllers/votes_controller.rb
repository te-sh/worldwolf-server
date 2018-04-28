class VotesController < ApplicationController
  def create
    vote = Vote.new(create_param)
    raise Forbidden unless vote.voter == @user
    if vote.save
      head :ok
    else
      head :bad_request
    end
  end

  private

  def create_params
    params.require(:vote).permit(:game_id, :voter, :votee)
  end
end
