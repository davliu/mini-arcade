class ScoresController < ApplicationController
  def spinning_game
    @user = User.find_by_id(session[:user_id])
  end
end
