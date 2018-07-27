defmodule Computer.State do
  @moduledoc "word_list for best guesses"
  alias Computer.State

  defstruct(
    word_length: nil,
    word_list: [],
    letters_list: [],
    game_service: nil
  )
end
