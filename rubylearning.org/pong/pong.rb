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

# BUG/TODO/TOWORKAROUND - mouse movement is not tracked/updated fast enough.  It's possible to whip the mouse across and out of the program window, and the paddle will not be trapped in the left wall.  To remedy this, track if the mouse enters/leaves the window.  Track the positioning over time of the paddle.  If the mouse is out, and the position looked like it was going left, then peg the paddle to the left.  Same with the right.

# IDEA:  The longer the game plays, the less wide the paddles become, the faster the ball goes.  Can even flash some text up..

# User-serviceable variables.
program_version = 0.1
window_height = 400
window_width = 400
ball_radius = 7
paddle_width = 60
paddle_height = 10
playing_field_boundery = 6
ball_speed = 10
background_color = '#333333'..'#000000'
ball_fill = '#FF0000' # red
ball_stroke = '#000000' # black
playing_field_stroke = '#FFAA00' # orange
computer_paddle_fill = '#990099' # purple
computer_paddle_stroke = '#000000' # black
computer_paddle_curve = 3
player_paddle_fill = '#FFAA00' # orange
player_paddle_stroke = '#000000' # black
player_paddle_curve = 3
#
#
y_paddle_limit_down  = ( window_height - paddle_height - playing_field_boundery - 5 )
x_paddle_limit_right = ( window_width  - paddle_width  - playing_field_boundery - 3 )
y_paddle_limit_up = y_paddle_limit_down
x_paddle_limit_left = ( playing_field_boundery + 3 )
#
@@y_ball_limit_down  = ( y_paddle_limit_down - ( ball_radius * 2 ) )
@@x_ball_limit_right = ( x_paddle_limit_right - ( ball_radius * 2 ) + paddle_width )
@@y_ball_limit_up   = playing_field_boundery + ball_radius + paddle_height - 2
@@x_ball_limit_left = playing_field_boundery + ( ball_radius / 2 )
# A ball appears (left-top side) and moves smoothly to right-bottom side at 20 frames per second.
ball_x = @@x_ball_limit_left
ball_y = @@y_ball_limit_up
# The middle would be:
#ball_x = ( width  / 2 ) - ( ball_radius / 2 )
#ball_y = ( height / 2 ) - ( ball_radius / 2 )
# The ball begins moving to the bottom-right-ish.
ball_angle = 90 + 45 # math is hard.

def ball_movement(
              ball_x,
              ball_y,
              ball_angle,
              ball_speed
  )
  
    # Direction and speed.
    # TODO: Check for a collision and do stuff with it.
    # Restrict ball x
    if    ball_x + ball_speed > @@x_ball_limit_right then
      # TODO
      ball_x = @@x_ball_limit_right
    elsif ball_x + ball_speed < @@x_ball_limit_left  then
      # TODO
      ball_x = @@x_ball_limit_left
    else
      ball_x += ball_speed
    end
    #
    # Restrict ball y
    if    ball_y + ball_speed > @@y_ball_limit_down then
      ball_y = @@y_ball_limit_down
    elsif ball_y + ball_speed < @@y_ball_limit_up   then
      # TODO
      ball_y = @@y_ball_limit_up
    else
      ball_y += ball_speed
    end

  return ball_x, ball_y, ball_angle, ball_speed
end

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
  background( background_color )
  # Computer paddle sarting position.  It tries to follow the ball.
  # This doesn't matter much, since as soon as the game begins and the ball moves, the computer paddle will move appropriately.
  computer_x = 10
  computer_y = 10
  # Player paddle starting position.  It follows the mouse.
  # This doesn't matter much, since as soon as the user's mouse enters the window the paddle will move appropriately.
  player_x = x_paddle_limit_right
  player_y = y_paddle_limit_down
  @computer_paddle = (
    rect(
      computer_x,
      computer_y,
      paddle_width,
      paddle_height,
      :stroke => computer_paddle_stroke,
      :fill => computer_paddle_fill,
      :curve => computer_paddle_curve,
    )
  )
  @player_paddle = (
    rect(
      player_x,
      player_y,
      paddle_width,
      paddle_height,
      :stroke => player_paddle_stroke,
      :fill => player_paddle_fill,
      :curve => player_paddle_curve,
    )
  )
  @ball = (
    oval(
      :left => ball_x,
      :top => ball_y,
      :radius => ball_radius,
      :fill => ball_fill,
      :stroke => ball_stroke,
    )
  )

  # 2. Show two paddles and a ball
  # Allocate computer paddle on the top (immobile yet).
  @computer_paddle.move( computer_x, computer_y )
  # Allocate player's (your) paddle on the bottom.
  @player_paddle.move( player_x, player_y )
  # Ball
  @ball.move( ball_x, ball_y )
  # Playing field.
  # TODO:  Is there a dashed stroke?
  # TODO:  Is there a "transparent" fill?  Then I just drop a square.
  # top
  line(
    playing_field_boundery,                 # origin x
    playing_field_boundery,                 # origin y
    window_width - playing_field_boundery,  # destination y
    playing_field_boundery,                 # destination y
    :stroke => playing_field_stroke,
  )
  # left
  line(
    playing_field_boundery,
    playing_field_boundery,
    playing_field_boundery,
    window_height - playing_field_boundery,
    :stroke => playing_field_stroke,
  )
  # right
  line(
    window_height - playing_field_boundery,
    playing_field_boundery,
    window_height - playing_field_boundery,
    window_width - playing_field_boundery,
    :stroke => playing_field_stroke,
  )
  # bottom
  line(
    playing_field_boundery,
    window_height - playing_field_boundery,
    window_width - playing_field_boundery,
    window_height - playing_field_boundery,
    :stroke => playing_field_stroke,
  )

  # A ball appears left-top side and (moves smoothly to right-bottom side at 20 frames per second).
  animate( 20 ) do
    @ball.move( ball_x, ball_y )
    ball_x, ball_y, ball_angle, ball_speed = ball_movement( ball_x, ball_y, ball_angle, ball_speed )
    #p "#{ball_x}x #{ball_y}y #{ball_angle} #{ball_speed}"
  end

# 3. Lock-in the ball within the window
# Bounce a ball on the edge of the window.


  # Your paddle synchronizes with the mouse movement.
  motion do | mouse_x, mouse_y |
    append do
      @player_paddle.move( player_x, player_y )
    end
    #
    player_x = mouse_x
    # Restrict paddle x
    if player_x > x_paddle_limit_right then player_x = x_paddle_limit_right end
    if player_x < x_paddle_limit_left  then player_x = x_paddle_limit_left  end
    #
    player_y = mouse_y
    # Restrict paddle y
    if player_y > y_paddle_limit_down then player_y = y_paddle_limit_down end
    if player_y < y_paddle_limit_up   then player_y = y_paddle_limit_up   end
  end
end



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
