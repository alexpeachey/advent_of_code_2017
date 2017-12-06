defmodule Day4 do
  @moduledoc """
  A new system policy has been put in place that requires all accounts to use a passphrase instead of simply a password. A passphrase consists of a series of words (lowercase letters) separated by spaces.
  """

  @doc """
  Validate a passphrase

  ## Examples

      iex> Day4.validate("aa bb cc dd ee")
      true

      iex> Day4.validate("aa bb cc dd aa")
      false

      iex> Day4.validate("aa bb cc dd aaa")
      true

  """
  def validate(phrase) do
    words = phrase |> String.split(" ") |> Enum.sort
    length(words) == length(Enum.uniq(words))
  end

  @doc """
  Validate a passphrase against anagrams

  ## Examples

      iex> Day4.validate2("abcde fghij")
      true

      iex> Day4.validate2("abcde xyz ecdab")
      false

      iex> Day4.validate2("a ab abc abd abf abj")
      true

      iex> Day4.validate2("iiii oiii ooii oooi oooo")
      true

      iex> Day4.validate2("oiii ioii iioi iiio")
      false

  """
  def validate2(phrase) do
    words = phrase |> String.split(" ") |> Enum.sort |> Enum.map(&String.to_charlist/1) |> Enum.map(&Enum.sort/1)
    length(words) == length(Enum.uniq(words))
  end

  @doc """
  Validate a passphrase list

  ## Examples

      iex> Day4.validate_list("aa bb cc dd ee\\naa bb cc dd aa\\naa bb cc dd aaa\\n")
      2

  """
  def validate_list(phrases) do
    phrases
    |> String.split("\n")
    |> Enum.reject(fn phrase -> phrase == "" end)
    |> Enum.count(fn phrase -> validate(phrase) end)
  end

  @doc """
  Validate a passphrase list against anagrams

  ## Examples

      iex> Day4.validate_list2("abcde fghij\\nabcde xyz ecdab\\a ab abc abd abf abj\\n")
      2

  """
  def validate_list2(phrases) do
    phrases
    |> String.split("\n")
    |> Enum.reject(fn phrase -> phrase == "" end)
    |> Enum.count(fn phrase -> validate2(phrase) end)
  end

end
