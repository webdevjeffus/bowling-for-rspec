require './bowling.rb'

# game = Game.new(4)

# game.play_game

# game.players.each do |player|
#   score = player.total_score
#   print player.frames.to_s + ": "
#   puts score
# end

# puts "The winner is player number #{game.find_winner + 1}!"

game = Game.new

# 3.times do
  player = Player.new
  player.frames = [ [0,0], [0,0], [0,0], [0,0], [0,0],
                    [0,0], [0,0], [0,0], [0,0], [10,0] ]

  score = player.total_score
  print player.frames.to_s + ": "
  puts score
# end