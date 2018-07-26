defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "word_list" do
    assert Dictionary.word_list() |> is_list() == true
    assert Dictionary.word_list() |> Enum.count() == 8881
    assert Dictionary.word_list() |> Enum.member?("energy")
  end

  test "random_word" do
    word = Dictionary.random_word()

    assert word |> is_bitstring() == true
    assert Dictionary.word_list() |> Enum.member?(word)
  end

  describe "words_by_length" do
    test "returns a list of strings" do
      words = Dictionary.words_by_length(4)
      assert is_list(words)
      assert Enum.all?(words, fn(word) -> is_binary word end)
    end

    test "returns words of the correct length" do
      assert 4
      |> Dictionary.words_by_length()
      |> Enum.all?(fn(word) -> String.length(word) == 4 end) == true
    end
  end
end
