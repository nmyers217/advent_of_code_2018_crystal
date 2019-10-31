abstract class Problem
  abstract def parse_input(filePath : String)
  abstract def solve
end

require "./day01"
require "./day02"

# TODO: command line argument parsing for running a particular problem
# https://crystal-lang.org/api/0.31.1/OptionParser.html

Day1.new.parse_input(Path.new(__DIR__, "day01", "input.txt")).solve
puts
Day2.new.parse_input(Path.new(__DIR__, "day02", "input.txt")).solve
