defmodule Computer.Player do
  @moduledoc " computer player for hangman "

  alias Computer.Guess

  def play(computer = %{game_service: game}) do
    make_move(game, Guess.get_guesses(computer))
  end

  def make_move(game = %Hangman.Game{game_state: state}, _computer)
  when state in [:won, :lost] do
    letters_used = game.used |> Enum.reverse() |> Enum.join(", ")
    winning_word = game.letters |> Enum.join("")

    exit_with_message(
      "The computer #{state} using #{letters_used} for #{winning_word}"
    )
  end

  def make_move(game = %Hangman.Game{game_state: :bad_guess}, computer) do
    game      = %{game | game_state: nil}
    computer  =
      computer
      |> Guess.get_improved_list()
      |> Map.put(:game_service, game)

    make_move(game, computer)
  end

  def make_move(game, computer) do
    [guess | rest_of_list] = computer.letters_list
    {game, tally} = Hangman.make_move(game, guess)
    updated_computer =
      %{computer | tally: tally, letters_list: rest_of_list, game_service: game}

    make_move(game, updated_computer)
  end

  def exit_with_message(msg) do
    IO.puts msg
    exit :normal
  end
end
