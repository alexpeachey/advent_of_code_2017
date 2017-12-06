defmodule Day5 do
  @moduledoc """
  The message includes a list of the offsets for each jump. Jumps are relative: -1 moves to the previous instruction, and 2 skips the next one. Start at the first instruction in the list. The goal is to follow the jumps until one leads outside the list.

  In addition, these instructions are a little strange; after each jump, the offset of that instruction increases by 1. So, if you come across an offset of 3, you would move three instructions forward, but change it to a 4 for the next time it is encountered.
  """

  @doc """
  Escape the jump maze

  ## Examples

      iex> Day5.escape("0\\n3\\n0\\n1\\n-3\\n")
      5

  """
  def escape(maze) do
    maze
    |> String.split("\n")
    |> Enum.reject(fn phrase -> phrase == "" end)
    |> Enum.map(&String.to_integer/1)
    |> evaluate(0, 0)
  end

  @doc """
  Escape the harder jump maze

  ## Examples

      iex> Day5.escape2("0\\n3\\n0\\n1\\n-3\\n")
      10

  """
  def escape2(maze) do
    maze
    |> String.split("\n")
    |> Enum.reject(fn phrase -> phrase == "" end)
    |> Enum.map(&String.to_integer/1)
    |> evaluate2(0, 0)
  end

  defp evaluate(instructions, offset, steps) do
    jump = Enum.at(instructions, offset)
    if jump == nil do
      steps
    else
      updated = List.replace_at(instructions, offset, jump + 1)
      evaluate(updated, offset + jump, steps + 1)
    end
  end

  defp evaluate2(instructions, offset, steps) do
    jump = Enum.at(instructions, offset)
    cond do
      jump == nil ->
        steps
      jump >= 3 ->
        updated = List.replace_at(instructions, offset, jump - 1)
        evaluate2(updated, offset + jump, steps + 1)
      true ->
        updated = List.replace_at(instructions, offset, jump + 1)
        evaluate2(updated, offset + jump, steps + 1)
    end
  end
end
