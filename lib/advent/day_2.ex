defmodule Advent.Day2 do
  @spec calculate_checksum() :: integer()
  def calculate_checksum() do
    "lib/advent/day_2_input"
    |> File.read!()
    |> String.split()
    |> calculate_checksum()
  end

  @spec calculate_checksum([String.t()]) :: integer()
  def calculate_checksum(ids) do
    ids
    |> Enum.map(&check_id/1)
    |> Enum.unzip()
    |> Tuple.to_list()
    |> Enum.map(&Enum.sum/1)
    |> Enum.reduce(&Kernel.*/2)
  end

  def check_id(id) do
    id
    |> String.graphemes()
    |> Enum.reduce(%{}, fn word, acc ->
      Map.update(acc, word, 1, &(&1 + 1))
    end)
    |> Enum.reduce_while({0, 0}, fn {_, value}, acc ->
      case categorize_id(value, acc) do
        {1, 1} -> {:halt, {1, 1}}
        next_acc -> {:cont, next_acc}
      end
    end)
  end

  def categorize_id(value, {two_times, three_times}) when value == 2, do: {1, three_times}
  def categorize_id(value, {two_times, three_times}) when value == 3, do: {two_times, 1}
  def categorize_id(_, values), do: values
end
