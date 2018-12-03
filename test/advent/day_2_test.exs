defmodule Advent.Day2Test do
  use ExUnit.Case, async: true

  alias Advent.Day2

  describe "Day2.calculate_checksum" do
    test "gets checksum from inventory ids" do
      ids = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]
      assert Day2.calculate_checksum(ids) == 12
    end

    test "gets checksum from input file" do
      assert Day2.calculate_checksum() == 8118
    end
  end
end
