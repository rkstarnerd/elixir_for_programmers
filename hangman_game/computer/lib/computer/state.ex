defmodule Computer.State do
  @moduledoc "word_list for best guesses"

  defstruct(
    tally:        nil,
    word_list:    [],
    word_length:  nil,
    letters_list: [],
    game_service: nil
  )
end
