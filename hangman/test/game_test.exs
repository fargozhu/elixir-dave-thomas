defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state == :initializing
  end

  test "state isn't change for :won or :lost game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game()
        |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, 'x')
    end
  end

  test "first occurence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurence of letter is not already used" do
    game = Game.new_game()

    game = Game.make_move(game, "x")
    assert game.game_state != :already_used

    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "good guess is recognized" do
    game = Game.new_game("wible")
    game = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "bad guess is recognized" do
    game = Game.new_game("wible")
    game = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left < 7
  end
end
