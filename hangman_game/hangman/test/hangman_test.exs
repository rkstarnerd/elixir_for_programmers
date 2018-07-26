defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "make_move includes tally" do
    {_game, tally} = Hangman.new_game("test") |> Hangman.make_move("x")
    assert tally.game_state == :bad_guess
    assert tally.turns_left == 6
    assert Enum.member?(tally.correct_letters_guessed, "x") == false
  end
end
