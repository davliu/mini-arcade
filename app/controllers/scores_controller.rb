class ScoresController < ApplicationController

  def create
    @user = User.find_by_id(session[:user_id])
    @score = @user.scores.build(params[:score])
    @image = Score.score_to_image[@score[:points]]
    if @score.save
      respond_to do |format|
        format.js
      end
    end
  end
end
