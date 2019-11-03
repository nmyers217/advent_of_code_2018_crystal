require "colorize"

file_path = "#{__DIR__}/input.txt"
puts "#{"* Reading file".colorize(:yellow)}: #{file_path}..."
input = File.read_lines(file_path).map(&.to_i32)
puts " ==> Loaded..."
puts " ==> Beginning: #{input[0..5]}..."
puts " ==> End: #{input[input.size - 5..]}..."

puts "#{"* Solving".colorize(:yellow)}: #{__FILE__}..."

puts " ==> Part 1: #{input.sum.colorize(:green)}"

cur_freq = 0
seen = Set{cur_freq}
input.cycle.each do |freq|
  cur_freq += freq
  break if seen.includes? cur_freq
  seen.add cur_freq
end
puts " ==> Part 2: #{cur_freq.colorize(:green)}"
