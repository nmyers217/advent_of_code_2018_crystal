require "colorize"
require "../aoc.cr"

class Day1 < Problem
  @input : Array(Int32)

  def initialize
    @input = [] of Int32
  end

  def parse_input(filePath)
    puts "#{"* Reading file".colorize(:yellow)}: #{filePath}..."
    @input = File.read_lines(filePath).map do |line|
      line.to_i32
    end
    puts " ==> Loaded..."
    puts " ==> Beginning: #{@input[0..5]}..."
    puts " ==> End: #{@input[@input.size - 5..]}..."
    puts ""
    self
  end

  def solve
    puts "#{"* Solving".colorize(:yellow)}: #{__FILE__}..."

    puts " ==> Part 1: #{@input.sum.colorize(:green)}"

    visited = Set(Int32).new
    curFreq = 0
    i = 0
    until visited.includes? curFreq
      visited.add curFreq
      curFreq += @input[i]
      i = @input[i + 1]? ? i + 1 : 0
    end
    puts " ==> Part 2: #{curFreq.colorize(:green)}"
  end
end
