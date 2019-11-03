require "colorize"

def part_one(input)
  two_counts = 0
  three_counts = 0

  input.each do |id|
    is_two_count = false
    is_three_count = false

    chars = id.chars
    chars.uniq.each do |c|
      matches = chars.select(&.== c)
      is_two_count = true if matches.size == 2
      is_three_count = true if matches.size == 3
    end

    two_counts += 1 if is_two_count
    three_counts += 1 if is_three_count
  end

  two_counts * three_counts
end

def part_two(input)
  input.each do |id1|
    input.each do |id2|
      next if id1 == id2

      chars_off = id1.chars.each.zip(id2.chars.each)
        .map_with_index { |pair, i| {pair[0] != pair[1], i} }
        .select { |result| result[0] }

      if chars_off.size == 1
        i = chars_off[0][1]
        return id1[0...i] + id1[i + 1..]
      end
    end
  end
end

file_path = "#{__DIR__}/input.txt"
puts "#{"* Reading file".colorize(:yellow)}: #{file_path}..."
input = File.read_lines(file_path)
puts " ==> Loaded..."
puts " ==> Beginning: #{input[0..1]}..."
puts " ==> End: #{input[input.size - 2..]}..."
puts "#{"* Solving".colorize(:yellow)}: #{__FILE__}..."
puts " ==> Part 1: #{part_one(input).colorize(:green)}"
puts " ==> Part 2: #{part_two(input).colorize(:green)}"
