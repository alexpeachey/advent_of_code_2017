defmodule Day3 do
  @moduledoc """
  Each square on the grid is allocated in a spiral pattern starting at a location marked 1 and then counting up while spiraling outward.
  Requested data must be carried back to square 1 (the location of the only access port for this memory system) by programs that can only move up, down, left, or right. They always take the shortest path: the Manhattan Distance between the location of the data and square 1.
  """

  @doc """
  Compute Number of Steps

  ## Examples

      iex> Day3.steps(1)
      0
      iex> Day3.steps(12)
      3
      iex> Day3.steps(23)
      2
      iex> Day3.steps(1024)
      31

  """
  def steps(n) when n < 8 do
    {x, y} = 1 |> moves |> Enum.take(n - 1) |> walk({0, 0})
    IO.inspect {x, y}
    abs(0 - x) + abs(0 - y)
  end
  def steps(n) do
    k = blocks(n)
    {x, y} = k + 1 |> moves |> Enum.take(n - ((2*k)*((2*k) + 1)) - 1) |> walk({-k, k})
    abs(0 - x) + abs(0 - y)
  end

  defp moves(n) do
    ru = Enum.to_list(1..(2*n - 1))
    ld = Enum.to_list(1..(2*n))
    Enum.map(ru, fn _ -> {1, 0} end) ++
    Enum.map(ru, fn _ -> {0, -1} end) ++
    Enum.map(ld, fn _ -> {-1, 0} end) ++
    Enum.map(ld, fn _ -> {0, 1} end)
  end

  defp walk(instructions, start) do
    Enum.reduce(instructions, start, fn ({x, y}, {xs, ys}) -> {xs + x, ys + y} end)
  end

  defp blocks(n) do
    m = n |> :math.sqrt |> Float.floor |> round
    cond do
      rem(m,2) == 1 -> div(m - 1, 2)
      n >= m * (m + 1) -> div(m, 2)
      true -> div(m, 2) - 1
    end
  end

end
