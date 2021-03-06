defmodule Hangman do
  @moduledoc """
  API for Hangman game
  """

  alias Hangman.Game

  defdelegate new_game,       to: Game, as: :init_game
  defdelegate new_game(word), to: Game, as: :init_game
  defdelegate tally(game),    to: Game

  def make_move(game, guess) do
    game = Game.make_move(game, guess)
    {game, tally(game)}
  end
end
