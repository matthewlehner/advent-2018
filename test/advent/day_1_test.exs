defmodule Advent.Day1Test do
  use ExUnit.Case, async: true

  alias Advent.Day1

  describe "change_frequency/2" do
    test "it changes frequency" do
      assert 1 == Day1.change_frequency("+1", 0)
      assert -1 == Day1.change_frequency("-2", 1)
      assert 2 == Day1.change_frequency("+3", -1)
      assert 3 == Day1.change_frequency(" +1", 2)
    end
  end

  describe "calculate_frequency/2" do
    test "calculates frequency from the first example" do
      result =
        "+1, +1, +1"
        |> String.split(",")
        |> Enum.reduce(0, &Day1.change_frequency/2)

      assert 3 == result
    end

    test "calculates frequency from the second example" do
      result =
        "+1, +1, -2"
        |> String.split(",")
        |> Enum.reduce(0, &Day1.change_frequency/2)

      assert 0 == result
    end

    test "calculates frequency from the third example" do
      result =
        "-1, -2, -3"
        |> String.split(",")
        |> Enum.reduce(0, &Day1.change_frequency/2)

      assert -6 == result
    end
  end

  describe "Day1.calculate_frequency/0" do
    test "calculates frequency from file" do
      assert 411 == Day1.calculate_frequency()
    end
  end

  describe "Day1.calibrate_frequency/1" do
    test "with examples" do
      assert Day1.calibrate_frequency("+1, -1") == 0
      assert Day1.calibrate_frequency("+3, +3, +4, -2, -4") == 10
      assert Day1.calibrate_frequency("-6, +3, +8, +5, -6") == 5
      assert Day1.calibrate_frequency("+7, +7, -2, -7, -4") == 14
    end

    test "with data" do
      assert Day1.calibrate_frequency() == 56360
    end
  end
end
