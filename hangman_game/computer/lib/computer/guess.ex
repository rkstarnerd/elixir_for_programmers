defmodule Computer.Guess do
  @moduledoc " logic to make best guess "

  alias Computer.{Guess, WordList}

  def get_guesses(computer) do
    computer
    |> WordList.word_length()
    |> WordList.word_list_by_length()
    |> best_guesses()
  end

  def best_guesses(computer = %{word_list: words}) do
    letters =
      words
      |> letters_from_word_list()
      |> letters_by_frequency()

    %{computer | letters_list: letters}
  end

  def letters_from_word_list(words) do
    words
    |> Enum.join("")
    |> String.codepoints
  end

  def letters_by_frequency(letters) do
    letters
    |> Stream.uniq()
    |> count_letter_frequency(letters)
    |> Enum.sort_by(fn({_k, v}) -> v end)
    |> Enum.reverse()
    |> Keyword.keys()
  end

  def letter_count(letters, uniq_letter) do
    Enum.count(letters, fn(letter) -> letter == uniq_letter end)
  end

  def count_letter_frequency(uniq_letters, letters) do
    uniq_letters
    |> Enum.reduce(%{}, fn(uniq_letter, acc) ->
      count = letter_count(letters, uniq_letter)
      Map.put_new(acc, uniq_letter, count)
    end)
  end

  def get_improved_list(computer = %{game_service: game}) do
    game.used
    |> List.first()
    |> WordList.eliminate_words(computer)
    |> Guess.best_guesses()
    |> Guess.remove_used_letters()
    |> Map.put(:game_service, game)
  end

  def get_list_with_corresponding_letters(computer, word_as_list) do
    Enum.map(Range.new(0, computer.word_length-1), fn(index) ->
      correct_letter = computer.tally.correct_letters_guessed |> Enum.at(index)
      letter_in_word = Enum.at(word_as_list, index)
      if correct_letter != "_", do: {correct_letter, letter_in_word}
    end)
  end

  def remove_used_letters(computer = %{game_service: game, letters_list: letters}) do
    new_list = Enum.reject(letters, fn(letter) -> letter in game.used end)
    %{computer | letters_list: new_list}
  end
end
