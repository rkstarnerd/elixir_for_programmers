defmodule Computer.State do
  @moduledoc "word_list for best guesses"
  alias Computer.State

  defstruct(
    tally:        nil,
    word_list:    [],
    word_length:  nil,
    letters_list: [],
    game_service: nil,
  )
end
