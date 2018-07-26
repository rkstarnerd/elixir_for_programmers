defmodule HangmanGameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.init_game()
    assert game.game_state == :initializing
    assert Enum.empty?(game.letters) == false
    assert game.turns_left == 7

    Enum.map(game.letters, &(assert &1 == String.downcase(&1)))
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.init_game() |> Map.put(:game_state, state)
     assert ^game = Game.make_move(game, "x")
    end
  end

  describe "an occurrence of a letter" do
    setup do
      game = Game.init_game() |> Game.make_move("x")
      {:ok, game: game}
    end

    test "is not already used", context do
      assert context[:game].game_state != :already_used
    end

    test "is already used", context do
      assert context[:game].game_state != :already_used

      game = Game.make_move(context[:game], "x")
      assert game.game_state == :already_used
    end

    test "is a good guess", context do
      good_guess =
        context[:game].letters
        |> Enum.uniq()
        |> Enum.random()

      game = Game.make_move(context[:game], good_guess)
      assert game.game_state == :good_guess || :won
      assert game.turns_left == 6
    end

    test "is a winnning guess", context do
      [good_guess | rest_of_letters] = context[:game].letters |> Enum.uniq()

      game =
        context[:game]
        |> Map.put(:used, rest_of_letters)
        |> Game.make_move(good_guess)

      assert game.game_state == :won
      assert game.turns_left == 6
    end

    test "is a bad guess" do
      game =
        Game.init_game("test")
        |> Game.make_move("z")

      assert game.game_state == :bad_guess
      assert game.turns_left == 6
    end

    test "is a losing guess" do
      game =
        Game.init_game("test")
        |> Game.make_move("x")
        |> Map.put(:turns_left, 1)
        |> Game.make_move("q")

      assert game.game_state == :lost
    end
  end

  test "your turn" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.init_game("wibble")

    Enum.reduce(moves, [], fn({guess, state}, used) ->
      game =
        game
        |> Map.put(:used, used)
        |> Game.make_move(guess)

        assert game.game_state == state
        [guess | used]
    end)
  end
end
