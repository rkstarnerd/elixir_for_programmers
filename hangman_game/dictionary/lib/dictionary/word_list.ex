defmodule Dictionary.WordList do
  @moduledoc "implementation of dictionary api"

  @me __MODULE__

  def start_link do
    Agent.start_link(&word_list/0, name: @me)
  end

  def word_list do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!
    |> String.split
  end

  def random_word do
    Agent.get(@me, &Enum.random/1)
  end

  def words_by_length(length) do
    Enum.filter(word_list(), fn(word) -> String.length(word) == length end)
  end
end
