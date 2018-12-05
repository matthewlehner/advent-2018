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

  describe "Day2.find_id" do
    test "gets id from multiple inventory ids" do
      ids = ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]
      assert Day2.compare_ids("fghij", "fguij") == "fgij"
      assert Day2.check_common(ids) == "fgij"
      assert Day2.check_common(["abcde", "fghij"]) == false

      assert 1 == Day2.find_common()
    end
  end
end
