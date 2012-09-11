class ScoresController < ApplicationController

  def create
    @user = User.find_by_id(session[:user_id])
    @score = @user.scores.build(params[:score])
    @image = Score.score_to_image[@score[:points]]

    # Add up cumulative points
    if @score[:points] == 0 && @user.scores
      @user.update_attribute(:total_score, @user.scores.sum(:points))
    end

    if @score.save
      respond_to do |format|
        format.js
      end
    end
  end
end
