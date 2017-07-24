defmodule TextClient.Player do

  alias TextClient.{State, Summary, Prompter, Mover}

  #won, lost, good guess, bad guess, already used, initializing

  def play(%State{ tally: %{ game_state: :won, letter: letters}}) do
    finish_with_message("You won", letters)
  end

  def play(%State{ tally: %{ game_state: :lost, letters: letters}}) do
    finish_with_message("You lost", letters)
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good guess")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Bad guess")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(game, "Already used")
  end

  def play(game = %State{}) do
    continue(game)
  end

  defp continue_with_message(game, message) do
    IO.puts(["\n", message])
    continue(game)
  end

  defp continue(game = %State{}) do
    game
      |> Summary.display()
      |> Prompter.accept_move()
      |> Mover.make_move()
      |> play()
  end

  defp finish_with_message(message, letters) do
    IO.puts(["\n", message, "The world was #{Enum.join(letters)}"])
  end
end
