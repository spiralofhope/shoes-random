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

# User-serviceable variables.
program_version = 0.1
window_height = 400
window_width = 400
ball_radius = 7
paddle_width = 60
paddle_height = 4
playing_field_boundery = 6

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
  # 'grey' isn't valid.
  background lightblue..gray
  # TODO:  Convert these to hex values then move them to the top configuration area.
  ball_fill = red
  ball_stroke = black
  playing_field_stroke = orange
  computer_fill = purple
  computer_stroke = black
  player_fill = orange
  player_stroke = black
  #
  # Computer paddle sarting position.  It tries to follow the ball.
  computer_x = 10
  computer_y = 10
  # Player paddle starting position.  It follows the mouse.
  player_x = window_width - 10 - paddle_width
  player_y = window_height - 10 - paddle_height
  # Ball starting position.  It bounces around.
  ball_x = ( width  / 2 ) - ( ball_radius / 2 )
  ball_y = ( height / 2 ) - ( ball_radius / 2 )
  #
  @computer_paddle = (
    rect(
      computer_x,
      computer_y,
      paddle_width,
      paddle_height,
      :stroke => computer_stroke,
      :fill => computer_fill,
    )
  )
  @player_paddle = (
    rect(
      player_x,
      player_y,
      paddle_width,
      paddle_height,
      :stroke => player_stroke,
      :fill => player_fill,
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


  # Your paddle synchronizes with the mouse movement.
  motion do | mouse_x, mouse_y |
    append do
      @player_paddle.move( player_x, player_y )
    end
    #
    player_x = mouse_x
    # Restrict x
    # .. upper limit
    if player_x > ( window_width - 10 - paddle_width ) then
      player_x = ( window_width - 10 - paddle_width )
    elsif player_x < 10
      # .. lower limit
      # FIXME:  The paddle appears on the bottom-left the first time the mouse enters the play field.
      player_x = 10
    end
    #
    player_y = mouse_y
    # Restrict y
    # .. upper limit
    if player_y > ( window_height - 10 - paddle_height ) then
      player_y = ( window_height - 10 - paddle_height )
    elsif player_y < ( window_height - 10 - paddle_height )
      # .. lower limit
      player_y = ( window_height - 10 - paddle_height )
    end
  end
end


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
