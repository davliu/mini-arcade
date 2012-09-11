class GamePlayController < ApplicationController
  def spinning_game
    # Redirect if session variable does not exist
    if !session[:user_id]
      flash[:error] = "Provide a name before playing"
      redirect_to root_path
    else
      @user = User.find_by_id(session[:user_id])
      @user.scores.destroy_all
      @score = @user.scores.build
      @spinning_board = Score.get_spinning_board
    end
  end

  def game_over
    @user = User.find_by_id(session[:user_id])
    @top_users = User.all(order: 'total_score desc, created_at desc', limit: 10)
    reset_session
  end
end
