defmodule PatternMatching do
  def reverse({elem1, elem2}), do: {elem2, elem1}
  def match?(arg1, arg1), do: true
  def match?(_arg1, _arg2), do: false
end
