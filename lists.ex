defmodule Lists do
  def len([]),     do: 0
  def len([_h|t]), do: 1 + len(t)

  def sum([]),    do: 0
  def sum([h|t]), do: h + sum(t)

  #def double([]),    do: []
  #def double([h|t]), do: [ 2 * h | double(t) ]

  #def square([]),    do: []
  #def square([h|t]), do: [ h * h | square(t) ]

  #def double(list, fn x -> 2 * x end), do: Enum.each(list, func)
  #def square(list), do: map(list, fn x -> x * x end)

  def map([], _func), do: []
  def double(list), do: Enum.map(list, fn x -> 2 * x end)
  def square(list), do: Enum.map(list, fn x -> x * x end)

  #def map([h|t], func), do
    #[ func.(h) | map(t, func) ]
  #end

  def sum_pairs([]), do: []
  def sum_pairs([one_elem]), do: [one_elem]
  def sum_pairs([h1, h2 | t]), do: [h1 + h2 | sum_pairs(t)]

  def even_length(list), do: list |> len |> rem(2) == 0
end
