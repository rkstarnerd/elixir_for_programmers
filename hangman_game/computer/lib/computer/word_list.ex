defmodule Computer.WordList do
  @moduledoc "handles possible words"

  alias Computer.Guess

  def word_length(computer = %{game_service: game}) do
    length = Enum.count(game.letters)
    %{computer | word_length: length}
  end

  def word_list_by_length(computer = %{word_length: length}) do
    list = Dictionary.words_by_length(length)
    %{computer | word_list: list}
  end

  def eliminate_words(bad_guess, computer) do
    list = reject_words_with_bad_guess(bad_guess, computer)

    new_list =
      case any_correct_letters?(computer) do
        true -> filter_based_on_position(list, computer)
        _    -> list
      end

    %{computer | word_list: new_list}
  end

  def reject_words_with_bad_guess(bad_guess, computer) do
    computer.word_list
    |> Enum.reject(fn(word) -> String.contains?(word, bad_guess) end)
  end

  def any_correct_letters?(computer) do
    computer.tally.correct_letters_guessed
    |> Enum.any?(fn(letter) -> letter != "_" end)
  end

  def filter_based_on_position(list, computer) do
    list
    |> Stream.map(fn(word) -> String.codepoints(word) end)
    |> Stream.filter(fn(word_as_list) ->
      get_words_with_corresponding_letters(computer, word_as_list)
    end)
    |> Enum.map(fn(word) -> Enum.join(word, "") end)
  end

  def get_words_with_corresponding_letters(computer, word_as_list) do
    computer
    |> Guess.get_list_with_corresponding_letters(word_as_list)
    |> Stream.reject(fn(value) -> is_nil(value) end)
    |> Stream.filter(fn({correct_letter, letter_in_word}) ->
      correct_letter == letter_in_word end)
      |> Enum.any?
  end
end
