defmodule TextClient.HangmanClient do
  @moduledoc "client for hangman"

  alias TextClient.State

  def make_move(game_state = %State{game_service: game, guessed: guess}) do
    {game, tally} = Hangman.make_move(game, guess)
    %{game_state | game_service: game, tally: tally}
  end
end
