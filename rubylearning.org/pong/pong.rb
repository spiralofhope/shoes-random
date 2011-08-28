=begin
1. Open Shoes Window
    Window's width and height are both 400 pixel.
    Show your app name and revision number on the window's title bar.

2. Show two paddles and a ball
    Allocate computer paddle on the top (immobile yet).
    Allocate player's (your) paddle on the bottom.
    Your paddle synchronizes with the mouse movement.
    A ball appears left-top side and moves smoothly to right-bottom side at 20 frames per second.

3. Lock-in the ball within the window
    Bounce a ball on the edge of the window.
    Computer's paddle synchronizes with the ball movement.

4. Hit the ball
    Have your paddle hit the ball.
    have computer's paddle hit the ball.
    Change ball's speed and bounce angle when the ball is hit.

5. Have a match
    When the ball goes over the goal lines, game finishes with victory message.
=end

program_version = 0.1
window_height = 400
window_width = 400
ball_radius = 7
paddle_width = 60
paddle_height = 4

# 1. Open Shoes Window
Shoes.app(
            # Window's width and height are both 400 pixel.
            :width => window_width,
            :height => window_height,
            # Show your app name and revision number on the window's title bar.
            :title => "spiralofhope\'s pong, v#{ program_version }",
            #
            :resizable => false,
) do
  background "#999"

  # Really this is just the starting position.  It follows the mouse.
  player_x = window_width - 10 - paddle_width
  player_y = window_height - 10

  # 2. Show two paddles and a ball
  # Allocate computer paddle on the top (immobile yet).
  rect(
    10, # x
    10, # y
    paddle_width,
    paddle_height,
  )
  # Allocate player's (your) paddle on the bottom.
  rect(
    player_x,
    player_y,
    paddle_width,
    paddle_height,
  )
  # Ball
  oval(
    :left => ( width  / 2 ) - ( ball_radius / 2 ),
    :top =>  ( height / 2 ) - ( ball_radius / 2 ),
    :radius => ball_radius
  )

  stroke "#000"
  motion do |_x, _y|
    if player_x and player_y and (player_x != _x or player_y != _y)
      append do
        #line player_x, player_y, _x, _y
stroke rgb(0, 0.6, 0.9)
rect(
  player_x,
  player_y,
  paddle_width,
  paddle_height,
)
      end
    end
    player_x, player_y = _x, _y
    # Restrict x
    # upper limit
    player_x = ( window_width - 10 - paddle_width ) if player_x > ( window_width - 10 - paddle_width )
    # lower limit
    # FIXME:  The paddle appears on the left the first time the mouse enters the play field.
    player_x = 10 if player_x < 10
    # Restrict y
    # upper limit
    player_y = ( window_height - 10 ) if player_y > ( window_height - 10 )
    # lower limit
    player_y = ( window_height - 10 ) if player_y < ( window_height - 10 )
  end


end



# Your paddle synchronizes with the mouse movement.
# A ball appears left-top side and moves smoothly to right-bottom side at 20 frames per second.


=begin

IDEAS:

Quitting.  Would be better as a menu, with a hotkey.

  button(
          "Quit",
          :top => 1,
          :left => 1,
  ) do
    quit unless confirm "Quit?"
  end

=end
