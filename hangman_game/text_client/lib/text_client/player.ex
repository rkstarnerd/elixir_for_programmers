defmodule TextClient.Player do
  @moduledoc "player module"

  alias TextClient.{State, Summary, Prompter, HangmanClient}

  def play(game_state = %State{tally: %{game_state: :won}}) do
    word = Enum.join(game_state.game_service.letters, "")
    exit_with_message("Yes! The word was #{word}!  You won!!")
  end

  def play(game_state = %State{tally: %{game_state: :lost}}) do
    word = Enum.join(game_state.game_service.letters, "")
    exit_with_message("Sorry, you lost.\n The word was: #{word}")
  end

  def play(game_state = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game_state, "Good guess!")
  end

  def play(game_state = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game_state, "Sorry, that isn't in the word.")
  end

  def play(game_state = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(game_state, "You've already used that letter")
  end

  def play(game_state) do
    continue(game_state)
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end

  def continue_with_message(game_state, msg) do
    IO.puts msg
    continue(game_state)
  end

  def continue(game_state) do
    game_state
    |> Summary.display()
    |> Prompter.accept_move()
    |> HangmanClient.make_move()
    |> play()
  end
end
