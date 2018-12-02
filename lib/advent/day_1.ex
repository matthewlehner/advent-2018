defmodule Advent.Day1 do
  @type calibration_setting :: {
          frequency :: integer(),
          values_set :: MapSet.t()
        }

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

  def calculate_frequency() do
    get_data()
    |> Enum.reduce(0, &change_frequency/2)
  end

  def calibrate_frequency(changes) do
    changes
    |> String.split(",")
    |> Stream.map(&String.trim/1)
    |> Stream.map(&normalize_change/1)
    |> Stream.cycle()
    |> Enum.reduce_while(default_calibration_setting(), &check_calibration/2)
  end

  def calibrate_frequency do
    get_data()
    |> Stream.cycle()
    |> Enum.reduce_while(default_calibration_setting(), &check_calibration/2)
  end

  @spec check_calibration(integer(), calibration_setting()) ::
          {:cont, calibration_setting()} | {:halt, integer()}
  def check_calibration(change, {frequency, previous_frequencies}) do
    next_frequency = change_frequency(change, frequency)

    case MapSet.member?(previous_frequencies, next_frequency) do
      true -> {:halt, next_frequency}
      false -> {:cont, {next_frequency, MapSet.put(previous_frequencies, next_frequency)}}
    end
  end

  @spec default_calibration_setting() :: calibration_setting()
  def default_calibration_setting do
    {0, MapSet.new([0])}
  end

  @spec get_data() :: [String.t()]
  def get_data do
    "lib/advent/day1-input"
    |> File.read!()
    |> String.split()
  end
end
