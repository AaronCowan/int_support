defmodule IntSupport do
  @moduledoc """
  A port of Rail's ActiveSupport Integer extensions.
  """

  @moduledoc since: "0.1.0"

  @doc """
  Returns a string of the passed integer with the associated ordinal appended.

  ## Examples
      iex> IntSupport.ordinalize(1)
      "1st"
      iex> IntSupport.ordinalize(2)
      "2nd"
      iex> IntSupport.ordinalize(52)
      "52nd"
      iex> IntSupport.ordinalize(53)
      "53rd"
      iex> IntSupport.ordinalize(2009)
      "2009th"
      iex> IntSupport.ordinalize(-21)
      "-21st"
      iex> IntSupport.ordinalize(-134)
      "-134th"
  """
  @doc since: "0.1.0"
  def ordinalize(0), do: 0
  def ordinalize(int) when int < 0, do: "-" <> ordinalize(abs(int))

  def ordinalize(int) do
    int
    |> Integer.digits()
    |> List.last()
    |> ordinalize(Integer.to_string(int))
  end

  defp ordinalize(last_digit, int_string) when abs(last_digit) == 1, do: int_string <> "st"
  defp ordinalize(last_digit, int_string) when abs(last_digit) == 2, do: int_string <> "nd"
  defp ordinalize(last_digit, int_string) when abs(last_digit) == 3, do: int_string <> "rd"

  defp ordinalize(last_digit, int_string) when int_string >= 4 or last_digit == 0,
    do: int_string <> "th"

  @doc """
  Converts an integer into a phone number formatted string.

  ## Examples
      iex> IntSupport.to_phone_number(5551234)
      "555-1234"
      iex> IntSupport.to_phone_number(1235554444)
      "(123) 555-4444"
  """
  def to_phone_number(int) when is_integer(int) do
    int
    |> Integer.to_string()
    |> to_phone_number
  end

  def to_phone_number(<<head::binary-size(3)>> <> <<tail::binary-size(4)>>) do
    head <> "-" <> tail
  end

  def to_phone_number(
        <<area_code::binary-size(3)>> <> <<head::binary-size(3)>> <> <<tail::binary-size(4)>>
      ) do
    "(" <> area_code <> ") " <> head <> "-" <> tail
  end
end
