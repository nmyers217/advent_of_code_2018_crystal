abstract class Problem
  abstract def parse_input(filePath : String)
  abstract def solve
end

require "./day01"
require "./day02"

# TODO: command line argument parsing for running a particular problem

# Day1.new.parse_input("./day01/input.txt").solve
Day2.new.parse_input("./day02/input.txt").solve
