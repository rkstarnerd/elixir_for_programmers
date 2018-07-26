defmodule TextClient.Summary do
  @moduledoc "display for hangman"

  alias TextClient.State

  def display(game_state = %State{game_service: game, tally: tally}) do
    IO.puts [
      "\n",
      "Word so far:  #{Enum.join(tally.letters_guessed, " ")}\n",
      "Letters used: #{game.used |> Enum.sort() |> Enum.join(" ")}\n",
      "Guesses left: #{tally.turns_left}\n",
    ]
    game_state
  end
end
