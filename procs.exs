defmodule Procs do
  def greeter(what_to_say) do
    receive do
      {:hello, name} ->
        IO.puts "#{what_to_say}: Hello!"
        greeter(name)
      {:boom, reason} ->
        IO.puts "Because #{reason}: Tick, Tick, Boom."
        exit(reason)
      msg ->
        IO.puts "#{what_to_say}: #{msg}"
        [:gem, :kat, :zak] |> Enum.random() |> greeter()
    end
  end
end
