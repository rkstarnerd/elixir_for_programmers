defmodule Dictionary.Application do
  use Application
  @moduledoc "Application module that acts as the Dictionary app entry point"

  alias Dictionary.WordList

  def start(_type, _args) do
    WordList.start_link()
  end
end
