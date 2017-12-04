defmodule Day1 do
  @moduledoc """
  The captcha requires you to review a sequence of digits (your puzzle input) and find the sum of all digits that match the next digit in the list. The list is circular, so the digit after the last digit is the first digit in the list.
  """

  @doc """
  Evaludate Captcha

  ## Examples

      iex> Day1.captcha(1122)
      3
      iex> Day1.captcha(1111)
      4
      iex> Day1.captcha(1234)
      0
      iex> Day1.captcha(91212129)
      9

  """
  def captcha(n) do
    a = n |> digits |> Enum.reverse
    b = shift(a, 1)
    sum(a, b)
  end

  @doc """
  Evaludate Second Captcha

  ## Examples

      iex> Day1.captcha2(1212)
      6
      iex> Day1.captcha2(1221)
      0
      iex> Day1.captcha2(123425)
      4
      iex> Day1.captcha2(123123)
      12
      iex> Day1.captcha2(12131415)
      4

  """
  def captcha2(n) do
    a = n |> digits |> Enum.reverse
    b = shift(a, div(length(a), 2))
    sum(a, b)
  end

  defp shift(a, 0), do: a
  defp shift([h | tail], n), do: shift(tail ++ [h], n - 1)

  defp sum([x | t1], [y | t2]) when x == y, do: x + sum(t1, t2)
  defp sum([_ | t1], [_ | t2]), do: sum(t1, t2)
  defp sum([], []), do: 0

  defp digits(n) when n < 10, do: [n]
  defp digits(n), do: [rem(n, 10) | digits(div(n,10))]
end
