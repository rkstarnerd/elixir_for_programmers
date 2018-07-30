defmodule Dictionary do
  @moduledoc "api for dictionary"

  alias Dictionary.WordList

  defdelegate start(),                 to: WordList, as: :word_list
  defdelegate random_word(),           to: WordList, as: :random_word
  defdelegate random_word(word_list),  to: WordList, as: :random_word
  defdelegate words_by_length(length), to: WordList, as: :words_by_length
end
