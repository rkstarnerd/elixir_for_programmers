defmodule Computer.Player do
  @moduledoc " computer player for hangman "

  def letter_list do
    "../../assets/letters_by_frequency.txt"
    |> Path.expand(__DIR__)
    |> File.read!
    |> String.split
  end

  def start do
    Hangman.new_game()
    |> make_move(letter_list)
    |> IO.inspect()
  end

  def make_move(game = %Hangman.Game{game_state: :won}, _letter_list) do
    used = game.used
    word = Enum.join(game.letters, "")
    IO.puts "The computer won using #{used} for #{word}"
    exit :normal
  end

  def make_move(game = %Hangman.Game{game_state: :lost}, _letter_list) do
    used = game.used
    word = Enum.join(game.letters, "")
    IO.puts "The computer lost using #{used} for #{word}"
    exit :normal
  end

  def make_move(game, [guess | rest_of_list]) do
    {game, _tally} = Hangman.make_move(game, guess)
    IO.inspect game
    make_move(game, rest_of_list)
  end
end
