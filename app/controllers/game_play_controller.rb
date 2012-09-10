class GamePlayController < ApplicationController
  def spinning_game
    @user = User.find_by_id(session[:user_id])
    @score = @user.scores.build
    @spinning_board = Score.get_spinning_board
  end
end
