defmodule Advent.Day1 do
  @spec change_frequency(integer(), binary() | integer()) :: :error | integer()
  def change_frequency(change, current) do
    change
    |> normalize_change()
    |> Kernel.+(current)
  end

  defp normalize_change(change) when is_integer(change), do: change

  defp normalize_change(change) when is_binary(change) do
    change
    |> String.trim()
    |> Integer.parse()
    |> case do
      {change, _} -> change
      _ -> 0
    end
  end

  def calculate_frequency(changes) do
    changes
    |> String.split(",")
    |> Enum.reduce(0, fn current, change -> change_frequency(current, change) end)
  end

  def calculate_frequency() do
    "lib/advent/day1-input"
    |> File.read!()
    |> String.split()
    |> Enum.reduce(0, &change_frequency/2)
  end
end
