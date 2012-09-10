class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user
      redirect_to controller: 'game_play', action: 'spinning_game'
    else
      render 'new'
    end
  end
end
