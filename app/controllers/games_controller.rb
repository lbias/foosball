class GamesController < ApplicationController
  before_action :set_match
  before_action :set_game, only: :destroy

  def create
    @game = @match.games.build(game_params)
    flash[:error] = @game.errors.full_messages.join(', ') unless @game.save
    redirect_to @match
  end

  def destroy
    @game.destroy
    redirect_to @match, notice: 'Game was successfully destroyed.'
  end

  private

  def set_match
    @match = Match.find(params[:match_id])
  end

  def set_game
    @game = @match.games.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:score1, :score2)
  end  
end
