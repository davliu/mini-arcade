# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  points     :integer
#  rounds     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Score < ActiveRecord::Base
  attr_accessible :points, :rounds

  belongs_to :user

  validates :user_id, presence: true
  validates :points, presence: true
  validates :rounds, presence: true

  def Score.score_to_image
    return {
          50 => 'chrome_small.png',
          30 => 'firefox_small.png',
          10 => 'ie_small.png',
          0 => 'netscape_small.png',
    }
  end

  # Return an 2D array of the game board with image and score
  def Score.get_spinning_board
    @score_square = []
    @right_count = 0
    @left_count = 15
    @image_to_score = {
      "chrome_small.png" => 50,
      "firefox_small.png" => 30,
      "ie_small.png" => 10,
      "netscape_small.png" => 0
    }

    (0..6).each do |i|
      # Determine the image based on row
      case
        when i >= 6
          @img_name = 'chrome_small.png'
        when i >= 5
          @img_name = 'firefox_small.png'
        when i >= 4
          @img_name = 'ie_small.png'
        else
          @img_name = 'netscape_small.png'
      end

      @score_square[i] = []
      (0..6).each do |j|
        @score_square[i][j] = {"img" => 'blank_small.png', "score" => 0, 'order' => -1}
      end

      @first = true
      (0..6).each do |j|
        case i % 6
          when 0
            @j_cells_to_occupy = [3]
          when 1, 5
            @j_cells_to_occupy = [2, 4]
          when 2, 4
            @j_cells_to_occupy = [0, 1, 5, 6]
          when 3
            @j_cells_to_occupy = [0, 6]
        end

        # Determine the order and other properties
        if @j_cells_to_occupy.include? j
          if j >= 3
            if i == 4
              if @first
                @order = @right_count + 1
                @first = false
              else
                @order = @right_count - 1
              end
            else
              @order = @right_count
            end
            @right_count += 1
          else
            if i == 2
              if @first
                @order = @left_count -1
                @first = false
              else
                @order = @left_count + 1
              end
            else
              @order = @left_count
            end
            @left_count -= 1
          end
          @score_square[i][j] = {'img' => @img_name, 'score' => @image_to_score[@img_name], 'order' => @order}
        end
      end
    end
    return @score_square
  end
end
