defmodule Hangman.Game do
  @moduledoc """
  Implementation of Hangman API
  """

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters:    [],
    used:       []
  )

  def init_game(word) do
    %Hangman.Game{letters: word |> String.codepoints}
  end

  def init_game do
    %Hangman.Game{letters: Dictionary.random_word |> String.codepoints}
  end

  def make_move(game = %Hangman.Game{game_state: state}, _guess)
  when state in [:won, :lost] do
    game
  end

  def make_move(game, guess) do
    accept_move(game, guess, guess in game.used)
  end

  def tally(game) do
    %{
      game_state:      game.game_state,
      turns_left:      game.turns_left,
      correct_letters_guessed: game.letters |> reveal_guessed(game.used)
    }
  end

  defp accept_move(game, _guess, _already_guessed = true) do
    %{game | game_state: :already_used}
  end

  defp accept_move(game, guess, _not_already_guessed) do
    game
    |> Map.put(:used, [guess | game.used])
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    game_state =
      game.letters
      |> Enum.all?(fn(letter) -> letter in game.used end)
      |> won?()

    %{game | game_state: game_state}
  end

  defp score_guess(game = %Hangman.Game{turns_left: 1}, _not_good_guess) do
    %{game | game_state: :lost}
  end

  defp score_guess(game, _not_good_guess) do
    %{game | turns_left: (game.turns_left - 1), game_state: :bad_guess}
  end

  defp won?(true),   do: :won
  defp won?(_),      do: :good_guess

  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn(letter) -> reveal_letter(letter, letter in used) end)
  end

  defp reveal_letter(letter, _in_word = true), do: letter
  defp reveal_letter(_letter, _not_in_word),    do: "_"
end
