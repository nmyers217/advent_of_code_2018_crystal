require "colorize"

FABRIC_DIM = 1000
alias Fabric = Array(Array(Int32))

file_path = "#{__DIR__}/input.txt"
puts "#{"* Reading file".colorize(:yellow)}: #{file_path}..."
claims = File.read_lines(file_path).map do |line|
  match = line.match /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/
  match.not_nil!.captures.map(&.not_nil!.to_i)
end
puts " ==> Loaded..."
puts " ==> Beginning: #{claims[0..1]}..."
puts " ==> End: #{claims[claims.size - 2..]}..."
puts "#{"* Solving".colorize(:yellow)}: #{__FILE__}..."

# A fabric to mark claims on
fabric : Fabric = Array.new(FABRIC_DIM) { Array.new(FABRIC_DIM, 0) }

# Solve part 1
claims.each do |(id, x, y, width, height)|
  height.times do |dy|
    width.times { |dx| fabric[y + dy][x + dx] += 1 }
  end
end
conflict_count = fabric.sum(&.count(&.> 1))
puts " ==> Part 1: #{conflict_count.colorize(:green)}"

# Solve part 2
claims.each do |(id, x, y, width, height)|
  is_good = true
  height.times do |dy|
    width.times do |dx|
      if fabric[y + dy][x + dx] > 1
        is_good = false
        break
      end
    end
  end
  if is_good
    puts " ==> Part 2: #{id.colorize(:green)}"
    break
  end
end
