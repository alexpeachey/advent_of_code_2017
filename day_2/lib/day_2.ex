defmodule Day2 do
  @moduledoc """
  The spreadsheet consists of rows of apparently-random numbers. To make sure the recovery process is on the right track, they need you to calculate the spreadsheet's checksum. For each row, determine the difference between the largest value and the smallest value; the checksum is the sum of all of these differences.
  """

  @doc """
  Calculate the checksum of the spreadsheet

  ## Examples

      iex> Day2.checksum("5 1 9 5\\n7 5 3\\n2 4 6 8\\n")
      18

  """
  def checksum(spreadsheet) do
    spreadsheet
    |> to_matrix
    |> Enum.reduce(0, fn (row, sum) -> sum + Enum.max(row) - Enum.min(row) end)
  end

  @doc """
  It sounds like the goal is to find the only two numbers in each row where one evenly divides the other - that is, where the result of the division operation is a whole number. They would like you to find those numbers on each line, divide them, and add up each line's result.

  ## Examples

    iex> Day2.checksum2("5 9 2 8\\n9 4 7 3\\n3 8 6 5\\n")
    9

  """
  def checksum2(spreadsheet) do
    spreadsheet
    |> to_matrix
    |> Enum.reduce(0, fn (row, sum) -> sum + row_checksum(row) end)
  end

  defp row_checksum(row) do
    row
    |> combination(2)
    |> Enum.map(fn row -> Enum.sort(row, &(&2 < &1)) end)
    |> Enum.find(fn ([x,y]) -> rem(x, y) == 0 end)
    |> (fn ([x, y]) -> div(x, y) end).()
  end

  defp to_matrix(spreadsheet) do
    spreadsheet
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn row -> Enum.map(row, &String.to_integer/1) end)
    |> Enum.reject(&Enum.empty?/1)
  end

  defp combination(_, 0), do: [[]]
  defp combination([], _), do: []
  defp combination([x | xs], n), do: (for y <- combination(xs, n - 1), do: [x|y]) ++ combination(xs, n)
end
