defmodule Computer.WordList do
  @moduledoc "handles possible words"

  alias Computer.Guess

  def word_length(computer = %{game_service: game}) do
    length = Enum.count(game.letters)
		%{computer | word_length: length}
  end

  def word_list(computer = %{word_length: length}) do
		list = Dictionary.words_by_length(length)
		%{computer | word_list: list}
  end

	def eliminate_words(bad_guess, computer) do
		new_list =
			computer.word_list
			|> Enum.reject(fn(word) -> String.contains?(word, bad_guess) end)

		any_correct_letters =
			computer.tally.correct_letters_guessed
			|> Enum.any?(fn(letter) -> letter != "_" end)

		if any_correct_letters do
			new_list =
				filter_based_on_position(new_list, computer)
				|> Enum.map(fn(word) -> Enum.join(word, "") end)
		end

		%{computer | word_list: new_list}
	end

	def filter_based_on_position(list, computer) do
		words_to_lists_of_chars =
			Enum.map(list, fn(word) -> String.codepoints(word) end)

		Enum.filter(words_to_lists_of_chars, fn(word_as_list) ->
			Guess.get_list_with_corresponding_letters(computer, word_as_list)
			|> Enum.reject(fn(value) -> is_nil(value) end)
			|> Enum.filter(fn({correct_letter, letter_in_word}) -> correct_letter == letter_in_word end)
			|> Enum.any?
		end)
	end
end
