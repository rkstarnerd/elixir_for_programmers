defmodule TextClient do
  @moduledoc """
  module for text_client to hangman game
  """

  defdelegate start(), to: TextClient.Interact
end
