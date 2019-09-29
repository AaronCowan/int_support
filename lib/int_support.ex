defmodule IntSupport do
  @moduledoc """
  A port of Rail's ActiveSupport Integer extensions.
  """

  @moduledoc since: "0.1.0"

  @kilobyte 1024
  @megabyte @kilobyte * 1024
  @gigabyte @megabyte * 1024
  @terabyte @gigabyte * 1024

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

  @doc """
  Returns the number of bytes from passed number of kilobytes.

  ## Examples
      iex> IntSupport.kilobytes(2)
      2048
  """
  def kilobytes(int) when is_integer(int), do: int * @kilobyte

  @doc """
  Returns the number of bytes from passed number of megabytes.

  ## Examples
      iex> IntSupport.megabytes(3)
      3145728
  """
  def megabytes(int) when is_integer(int), do: int * @megabyte

  @doc """
  Returns the number of bytes from passed number of gigabytes.

  ## Examples
      iex> IntSupport.gigabytes(3)
      3221225472
  """
  def gigabytes(int) when is_integer(int), do: int * @gigabyte

  @doc """
  Returns the number of bytes from passed number of terabytes.

  ## Examples
      iex> IntSupport.terabytes(4)
      4398046511104
  """
  def terabytes(int) when is_integer(int), do: int * @terabyte

  @doc """
  Produce a string representation of a number as a human-readable number of bytes:

  ## Examples
      iex> IntSupport.bytes_to_human(123)
      "123 Bytes"
  """
  def bytes_to_human(int) when int < @kilobyte do
    Integer.to_string(int) <> " Bytes"
  end

  @doc """
  Produce a string representation of a number as a human-readable number of bytes:

  ## Examples
      iex> IntSupport.bytes_to_human(1234)
      "1.21 KB"
  """
  def bytes_to_human(int) when int < @megabyte do
    kb = Float.round(int / @kilobyte, 2)
    Float.to_string(kb) <> " KB"
  end

  @doc """
  Produce a string representation of a number as a human-readable number of bytes:

  ## Examples
      iex> IntSupport.bytes_to_human(1234567)
      "1.18 MB"
  """
  def bytes_to_human(int) when int < @gigabyte do
    mb = Float.round(int / @megabyte, 2)
    Float.to_string(mb) <> " MB"
  end

  @doc """
  Produce a string representation of a number as a human-readable number of bytes:

  ## Examples
      iex> IntSupport.bytes_to_human(1234567890)
      "1.15 GB"
  """
  def bytes_to_human(int) when int < @terabyte do
    gb = Float.round(int / @gigabyte, 2)
    Float.to_string(gb) <> " GB"
  end

  @doc """
  Produce a string representation of a number as a human-readable number of bytes:

  ## Examples
      iex> IntSupport.bytes_to_human(1234567890123)
      "1.12 TB"
  """
  def bytes_to_human(int) when int > @terabyte do
    tb = Float.round(int / @terabyte, 2)
    Float.to_string(tb) <> " TB"
  end
end
