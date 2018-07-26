defmodule TextClient.Prompter do
  @moduledoc "prompt for hangman"

  def accept_move(game_state) do
      IO.gets("Your guess: ")
      |> check_input(game_state)
  end

  defp check_input({:error, reason}, _game_state) do
    IO.puts("Game ended: #{reason}")
    exit :normal
  end

  defp check_input({:eof}, _game_state) do
    IO.puts("Womp! Okay.. ")
    exit :normal
  end

  defp check_input(guess, game_state) do
    guess = String.trim(guess)
    check_if_letter(guess =~ ~r/\A[a-z]\z/, game_state, guess)
  end

  defp check_if_letter(_is_letter = true, game_state, guess) do
    %{game_state | guessed: guess}
  end

  defp check_if_letter(_is_not_letter, game_state, _guess) do
    IO.puts "please enter a single lowecase letter"
    accept_move(game_state)
  end
end
