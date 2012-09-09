require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "play page" do
    before { visit play_path }
    it { should have_selector('h1', text: 'Mini Arcade') }
    it { should have_selector('title', text: 'Mini Arcade') }
  end
end
