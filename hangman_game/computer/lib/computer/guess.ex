defmodule Computer.Guess do
  @moduledoc " logic to make best guess "

	alias Computer.State
	alias Computer.Guess

  def get_guesses(computer) do
		computer
    |> word_length()
    |> word_list()
    |> best_guesses()
  end

  def word_length(computer = %{game_service: game}) do
    length = Enum.count(game.letters)
		%{computer | word_length: length}
  end

  def word_list(computer = %{word_length: length}) do
		list = Dictionary.words_by_length(length)
		%{computer | word_list: list}
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
    |> Enum.uniq()
    |> Enum.reduce(%{}, fn(uniq_letter, acc) ->
      count = letter_count(letters, uniq_letter)
      Map.put_new(acc, uniq_letter, count)
    end)
		|> Enum.sort_by(fn({k, v}) -> v end)
		|> Enum.reverse()
		|> Keyword.keys()
  end

  def letter_count(letters, uniq_letter) do
    Enum.count(letters, fn(letter) -> letter == uniq_letter end)
  end

	def get_improved_list(computer = %{game_service: game}) do
		game.used
		|> List.first()
		|> Guess.eliminate_words(computer)
		|> Guess.best_guesses()
		|> Guess.remove_used_letters()
		|> Map.put(:game_service, game)
	end

	def eliminate_words(bad_guess, computer) do
		new_list =
			computer.word_list
			|> Enum.reject(fn(word) -> String.contains?(word, bad_guess) end)

		%{computer | word_list: new_list}
	end

	def remove_used_letters( computer = %{game_service: game, letters_list: letters}) do
		new_list = Enum.reject(letters, fn(letter) -> letter in game.used end)
		%{computer | letters_list: new_list}
	end
end
