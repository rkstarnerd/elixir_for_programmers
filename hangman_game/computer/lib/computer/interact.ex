defmodule Computer.Interact do
  @moduledoc "computer plays hangman"

  alias Computer.{State, Player}

  def start() do
		Hangman.new_game()
    |> setup_state()
    |> Player.play()
  end

	def setup_state(game) do
    %State{
			word_length: nil,
      word_list:   [],
      letters_list: [],
      game_service: game
    }
  end
end
