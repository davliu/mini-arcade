require 'spec_helper'

describe "ScorePages" do
  subject { page }

  describe "spinning game page" do
    before { visit spinning_game_path }
  end
end
