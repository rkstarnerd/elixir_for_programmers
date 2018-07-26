defmodule Dictionary do
  @moduledoc "functions for dictionary"

  def word_list do
    "../assets/words.txt" |> Path.expand(__DIR__) |> File.read! |> String.split
  end

  def random_word do
    word_list |> Enum.random
  end
end
