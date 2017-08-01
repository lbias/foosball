class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  def index
    @matches = Match.includes(games: :winner, teams: :players)
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new
    @match.add_players_by(params[:player_ids]) if params[:player_ids].present?
    if @match.save
      redirect_to @match, notice: 'Match was successfully created.'
    else
      render :new
    end
  end

  def show
    @teams = @match.teams
    @games = @match.games
  end

  def destroy
    @match.destroy
    redirect_to matches_url, notice: 'Match was successfully destroyed.'
  end

  private
    def set_match
      @match = Match.find(params[:id])
    end
end
