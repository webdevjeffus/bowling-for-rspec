require './bowling'

RSpec.describe Player do

  describe "#initialize" do
    player = Player.new
    it "represents a player as a Player object" do
      expect(player).to be_an_instance_of Player
    end

    it "creates an array of frames for the player" do
      expect(player.frames).to be_an Array
    end
  end

  describe "#roll" do
    player = Player.new
    it "knocks down a number of pins between 0 and 'pins'" do
      pins = 10
      100.times do
        roll = player.roll(pins)
        expect(roll).to be >= 0
        expect(roll).to be <= pins
      end
    end
  end

  describe "#bowl_frame" do
    player = Player.new

    it "returns an array of two rolls" do
      frame = player.bowl_frame
      expect(frame).to be_an Array
      expect(frame.count).to eq 2
    end

    it "can total to no more than 10 pins" do
      100.times do
        frame = player.bowl_frame
        expect(frame[0] + frame[1]).to be <= 10
      end
    end
  end

  describe "#score_frame" do
    it "adds up the score for each roll in a frame" do
      player = Player.new
      player.frames << [3,4]
      expect(player.score_frame(0)).to eq 7
    end

    it "adds next roll for spares" do
      player = Player.new
      player.frames << [8,2] << [6,2]
      expect(player.score_frame(0)).to eq 16
    end

    it "adds next two rolls for strikes" do
      player = Player.new
      player.frames << [10,0] << [6,2]
      expect(player.score_frame(0)).to eq 18
    end

    it "adds extra roll for spare in 10th frame" do
      player = Player.new
      player.frames = [ [0,0], [0,0], [0,0], [0,0], [0,0],
                        [0,0], [0,0], [0,0], [0,0], [0,10] ]
      tenth_frame_score = player.score_frame(9)
      expect(tenth_frame_score).to eq 10 + player.frames[10][0]
    end

    it "adds two extra rolls for strike in 10th frame" do
      player = Player.new
      player.frames = [ [0,0], [0,0], [0,0], [0,0], [0,0],
                        [0,0], [0,0], [0,0], [0,0], [10,0] ]
      tenth_frame_score = player.score_frame(9)
      expect(tenth_frame_score).to eq 10 + player.frames[10][0] + player.frames[10][1]
    end
  end

  describe "#total_score" do
    player = Player.new
    it "totals the player's score for all frames without strikes or spares" do
      player.frames = [ [5,2], [7,2], [6,0], [3,4], [5,3] ]
      expect(player.total_score).to eq(37)
    end

    it "totals the player's score for all frames with spares" do
      player.frames = [ [5,2], [7,3], [6,0], [3,7], [5,3] ]
      expect(player.total_score).to eq(52)
    end

    it "totals the player's score for all frames with strikes" do
      player.frames = [ [5,2], [10,0], [6,0], [10,0], [5,3] ]
      expect(player.total_score).to eq(55)
    end

    it "totals the player's score for all frames with strikes and spares" do
      player.frames = [ [5,2], [10,0], [6,0], [5,5], [5,3] ]
      expect(player.total_score).to eq(52)
    end

    it "properly totals score for game with a spare in frame 10" do
      player = Player.new
      player.frames = [ [0,0], [0,0], [0,0], [0,0], [0,0],
                        [0,0], [0,0], [0,0], [0,0], [8,2] ]
      expect(player.total_score).to eq (10 + player.frames[10][0] + player.frames[10][1])
    end

    it "properly totals score for game with a strike in frame 10" do
      player = Player.new
      player.frames = [ [0,0], [0,0], [0,0], [0,0], [0,0],
                        [0,0], [0,0], [0,0], [0,0], [10,0] ]
      expect(player.total_score).to eq (10 + player.frames[10][0] + player.frames[10][1])
    end

    it "properly totals score for game with a strikes in 9 but not 10" do
      player = Player.new
      player.frames = [ [0,0], [0,0], [0,0], [0,0], [0,0],
                        [0,0], [0,0], [0,0], [10,0], [0,0] ]
      expect(player.total_score).to eq (10 + player.frames[10][0] + player.frames[10][1])
    end

    it "properly totals score for game with strikes in frames 9 and 10" do
      player = Player.new
      player.frames = [ [0,0], [0,0], [0,0], [0,0], [0,0],
                        [0,0], [0,0], [0,0], [10,0], [10,0] ]
      expect(player.total_score).to eq (30 + 2*player.frames[10][0] + player.frames[10][1])
    end

  end
end


RSpec.describe Game do

  describe "#initialize" do
    game = Game.new
    it "is an instance of the Game class" do
      expect(game).to be_an_instance_of Game
    end

    it "creates a Player object for each player" do
      num_players = 3
      game = Game.new(num_players)
      num_players.times do |i|
        expect(game.players[i]).to be_an_instance_of Player
      end
    end

    it "defaults to two players" do
      game = Game.new
      expect(game.players.count).to eq 2
    end

    it "includes a specified number of players" do
      game = Game.new(3)
      expect(game.players.count).to eq 3
    end
  end

  describe "#play_turn" do
    it "adds a frame to each player's frames array" do
      num_turns = 3
      game = Game.new
      num_turns.times do
        game.play_turn
      end
      game.players.each do |player|
        expect(player.frames.count).to eq num_turns
      end
    end
  end

  describe "#play_game" do
    it "adds 10 frames to each player's frames" do
      game = Game.new
      game.play_game
      game.players.each do |player|
        expect(player.frames.count).to eq 10
      end
    end
  end

  describe "#find_winner" do
    it "chooses the player with the highest score as winner" do
      game = Game.new
      game.players[0].frames = [ [5,2], [7,2], [6,0], [3,4], [5,3] ] # 37
      game.players[1].frames = [ [5,2], [10,0], [6,0], [10,0], [5,3] ] # 55
      expect(game.find_winner).to eq 1
    end
  end

end