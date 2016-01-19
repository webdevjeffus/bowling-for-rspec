require 'pry'
require 'pry-nav'

class Player
  attr_accessor :frames

  def initialize
    @frames = []
  end

  def roll(pins = 10)
    rand(pins + 1)
  end

  def bowl_frame
    frame = []
    frame << self.roll(10)
    frame << self.roll(10 - frame[0])
    frame
  end

  def score_frame(frames_index)
    score = 0
    frame = self.frames[frames_index]
    prev_frame = self.frames[frames_index - 1]
# binding.pry

    # Add extra rolls if necessary, for strikes and spares in 10th frame
    if frames_index == 9
      self.frames << [0,0]
      if frame[0] == 10
        self.frames[10] = [self.roll, self.roll]
      elsif frame[0] + frame[1] == 10 || prev_frame[0] == 10
        self.frames[10] = [self.roll, 0]
      # else
      #   self.frames << [0,0]
      end
    end

    # Set next frames, for spares and strikes
    next_frame = self.frames[frames_index + 1]
    unless frames_index == 9
      next_next_frame = self.frames[frames_index + 2]
    end
# binding.pry
    if frame[0] == 10
      if next_frame[0] == 10 && frames_index < 9
        total = frame[0] + next_frame[0] + next_next_frame[0]
      else
        total = frame[0] + next_frame[0] + next_frame[1]
      end
    elsif frame[0] + frame[1] == 10
      total = frame[0] + frame[1] + next_frame[0]
    else
      total = frame[0] + frame [1]
    end

    # if self.frames[8][0] == 10
    #   total += self.frames[10][1]
    # end

    total

  end

  def total_score
    total = 0
    num_turns = self.frames.count
    num_turns.times do |i|
      total += self.score_frame(i)
    end
    total
  end
end


class Game
  attr_accessor :players

  def initialize(num_players = 2)
    @players = []
    num_players.times do |i|
      @players << Player.new
    end
  end

  def play_turn
    self.players.each do |player|
      player.frames << player.bowl_frame
    end
  end

  def play_game
    10.times do
      self.play_turn
    end
  end

  def find_winner
    top_scorer = self.players.reduce do |top_scorer, player|
      top_scorer.total_score >= player.total_score ? top_scorer : player
    end
    self.players.find_index(top_scorer)
  end

end