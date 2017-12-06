defmodule Day6 do
  @moduledoc """
  In this area, there are sixteen memory banks; each memory bank can hold any number of blocks. The goal of the reallocation routine is to balance the blocks between the memory banks.

  The reallocation routine operates in cycles. In each cycle, it finds the memory bank with the most blocks (ties won by the lowest-numbered memory bank) and redistributes those blocks among the banks. To do this, it removes all of the blocks from the selected bank, then moves to the next (by index) memory bank and inserts one of the blocks. It continues doing this until it runs out of blocks; if it reaches the last memory bank, it wraps around to the first one.

  The debugger would like to know how many redistributions can be done before a blocks-in-banks configuration is produced that has been seen before.
  """

  @doc """
  Detect steps until loop is found.

  ## Examples

      iex> Day6.detect_loop("0  2  7  0")
      5

  """
  def detect_loop(banks) do
    banks
    |> parse
    |> reallocate
    |> steps
  end

  @doc """
  Detect size of found loop

  ## Examples

      iex> Day6.loop_size("0  2  7  0")
      4

  """
  def loop_size(banks) do
    banks
    |> parse
    |> reallocate
    |> size
  end

  defp steps({_, history}), do: length(history)

  defp size({banks, history}),
    do: Enum.find_index(history, fn prev -> prev == banks end) + 1

  defp parse(banks) do
    banks
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp reallocate(banks) do
    0..(length(banks) - 1)
    |> Enum.zip(banks)
    |> distribute([])
  end

  defp distribute(banks, seen) do
    done = Enum.find(seen, fn prev -> prev == banks end)
    if done do
      {banks, seen}
    else
      distribute(distribute(banks), [banks | seen])
    end
  end

  defp distribute(banks) do
    {index, distributable} = Enum.max_by(banks, fn {_, x} -> x end)

    banks
    |> List.replace_at(index, {index, 0})
    |> Enum.zip(adjustments(inc_index(index, length(banks)), distributable, length(banks)))
    |> Enum.map(fn ({{index, value}, adj}) -> {index, value + adj} end)
  end

  defp adjustments(index, distributable, size) do
    per_bank = div(distributable, size)
    extra = rem(distributable, size)

    0..(size - 1)
    |> Enum.map(fn _ -> per_bank end)
    |> allocate_extra(index, extra)
  end

  defp allocate_extra(adjustments, _, 0), do: adjustments
  defp allocate_extra(adjustments, index, extra) do
    adjustments
    |> List.replace_at(index, Enum.at(adjustments, index) + 1)
    |> allocate_extra(inc_index(index, length(adjustments)), extra - 1)
  end

  defp inc_index(index, size), do:
    if (index == size - 1), do: 0, else: index + 1

end
