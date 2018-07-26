defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "word_list" do
    assert Dictionary.word_list() |> is_list == true
    assert Dictionary.word_list() |> Enum.count == 8881
    assert Dictionary.word_list() |> Enum.member? "energy"
  end

  test "random_word" do
    word = Dictionary.random_word()

    assert word |> is_bitstring == true
    assert Dictionary.word_list() |> Enum.member? word
  end
end
