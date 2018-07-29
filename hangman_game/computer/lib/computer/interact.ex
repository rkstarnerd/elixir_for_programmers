defmodule Computer.Interact do
  @moduledoc "computer plays hangman"

  alias Computer.{Player, State}

  def start do
    Hangman.new_game()
    |> setup_state()
    |> Player.play()
  end

  def setup_state(game) do
    %State{
      tally:        nil,
      word_list:    [],
      word_length:  nil,
      letters_list: [],
      game_service: game
    }
  end
end
