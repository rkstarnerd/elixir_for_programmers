defmodule Dictionary do
  @moduledoc "functions for dictionary"

  def word_list do
    "../assets/words.txt" |> Path.expand(__DIR__) |> File.read! |> String.split
  end

  def random_word do
    word_list() |> Enum.random
  end

  def words_by_length(length) do
    Enum.filter(word_list(), fn(word) -> String.length(word) == length end)
  end
end
