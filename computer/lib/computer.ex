defmodule Computer do
  @moduledoc """
  interface for computer app that plays hangman
  """

  defdelegate start(), to: Computer.Player
end
