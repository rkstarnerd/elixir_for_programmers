defmodule Computer.Player do
  @moduledoc " computer player for hangman "

  def start do
    {:ok, pid} = StringIO.open("starting..", capture_prompt: true)
    pid
    |> TextClient.start()
    |> IO.stream(:line)
    |> Enum.each(fn(line) -> respond(line) end)
  end

  defp respond({"", "Your guess"}) do
    System.cmd("echo", "We got here")
    exit :normal
  end

  defp respond(data) do
    System.cmd("echo", "We got #{data}")
    exit :normal
  end
end
