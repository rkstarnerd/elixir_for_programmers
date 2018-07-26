defmodule Computer.Player do
  @moduledoc " computer player for hangman "

  def letter_list do
    "../../assets/letters_by_frequency.txt"
    |> Path.expand(__DIR__)
    |> File.read!
    |> String.split
  end

  def start do
    Hangman.new_game() |> make_move(letter_list)
  end

  def make_move(game = %Hangman.Game{game_state: :won}, _letter_list) do
    exit_with_message(
      "The computer won using #{game.used} for #{Enum.join(game.letters, "")}"
    )
  end

  def make_move(game = %Hangman.Game{game_state: :lost}, _letter_list) do
    exit_with_message(
      "The computer lost using #{game.used} for #{Enum.join(game.letters, "")}"
    )
  end

  def make_move(game, [guess | rest_of_list]) do
    {game, _tally} = Hangman.make_move(game, guess)
    make_move(game, rest_of_list)
  end

  def exit_with_message(msg) do
    IO.puts msg
    exit :normal
  end
end
