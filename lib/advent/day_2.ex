defmodule Advent.Day2 do
  def day_2_input do
    "lib/advent/day_2_input"
    |> File.read!()
    |> String.split()
  end

  @spec calculate_checksum() :: integer()
  def calculate_checksum() do
    day_2_input()
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

  def categorize_id(value, {_, three_times}) when value == 2, do: {1, three_times}
  def categorize_id(value, {two_times, _}) when value == 3, do: {two_times, 1}
  def categorize_id(_, values), do: values

  def find_common() do
    day_2_input()
    |> check_common()
  end

  @spec check_common([]) :: String.t() | false
  def check_common([id | ids]) do
    result =
      Enum.reduce_while(ids, nil, fn compared_id, acc ->
        case compare_ids(compared_id, id) do
          false -> {:cont, nil}
          string -> {:halt, string}
        end
      end)

    if is_binary(result) do
      result
    else
      check_common(ids)
    end
  end

  def check_common([]), do: false

  def compare_ids(id1, id2) do
    id1 = String.graphemes(id1)
    id2 = String.graphemes(id2)

    [id1, id2]
    |> List.zip()
    |> Enum.reduce_while({[], 0}, fn {grapheme1, grapheme2}, {chars, failures} ->
      response =
        case check_grapheme(grapheme1, grapheme2) do
          false -> {chars, failures + 1}
          grapheme -> {[grapheme | chars], failures}
        end

      case response do
        {_, 2} -> {:halt, false}
        _ -> {:cont, response}
      end
    end)
    |> case do
      false -> false
      {chars, _} -> chars |> Enum.reverse() |> Enum.join()
    end
  end

  def check_grapheme(grapheme, grapheme), do: grapheme
  def check_grapheme(_grapheme1, _grapheme2), do: false
end
