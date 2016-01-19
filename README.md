# Bowling for RSpec
### Exploring test-driven development

This toy program&mdash;the classes for a simple bowling game&mdash;was my first independent attempt at test-driven development (TDD). It was written in vanilla Ruby, and uses RSpec as its spec runner.

The program consists of two classes&mdash;Game and Player&mdash;each of which has a small amount of data, and a handful of methods. At the present time, it's all Model and no Controller or View; there's no way to play it interactively.  The number of pins knocked over with each roll is determined randomly, and the game is scored according to the standard rules for scoring bowling. I have added a file of driver code&mdash;**bowling_driver.rb**&mdash;to demonstrate the game.

The program was developed through a step-by-step, test-by-test process. At each point, I identified the next necessary fragment of code (usually method or a block within a method), and wrote a test specifying given conditions and expected returns. Only after writing each test did I write program code to pass that test, alternating between tests and methods as I worked. In a couple of tricky spots, such as when handling the edge cases presented by spares or strikes in the final frame of the game, I wrote two or three tests at a time to cover all possibilities, and then wrote the method to handle them.