require "colorize"

enum LogEvent
  Start
  Sleep
  Wake
end

file_path = "#{__DIR__}/input.txt"
puts "#{"* Reading file".colorize(:yellow)}: #{file_path}..."

log = File.read_lines(file_path).map do |line|
  match = line.match(/\[(.+)\] (.+)/).not_nil!
  time = Time.parse_utc(match[1], "%F %H:%M")

  case match[2]
  when /Guard #(\d+) begins shift/
    {guard: $1, time: time, event: LogEvent::Start}
  when /falls asleep/
    {guard: nil, time: time, event: LogEvent::Sleep}
  else
    {guard: nil, time: time, event: LogEvent::Wake}
  end
end

puts " ==> Loaded..."
puts " ==> Beginning: #{log[0..1]}..."
puts " ==> End: #{log[log.size - 2..]}..."
puts "#{"* Solving".colorize(:yellow)}: #{__FILE__}..."

guards = {} of String => Array(Int32)
active_guard = -1
slept_at = -1
log.sort_by(&.[:time]).each do |entry|
  case entry[:event]
  when LogEvent::Start
    g = entry[:guard].not_nil!
    guards[g] = Array.new(60) { 0 } if !guards[g]?
    active_guard = g
  when LogEvent::Sleep
    slept_at = entry[:time].minute
  when LogEvent::Wake
    woke_at = entry[:time].minute
    new_minutes = guards[active_guard][slept_at...woke_at].map(&.+ 1)
    guards[active_guard][slept_at...woke_at] = new_minutes
  end
end

sleepiest = guards
  .transform_values(&.sum)
  .max_by { |k, v| v }
most_slept = guards[sleepiest[0]]
  .zip(0...60)
  .max_by(&.[0])
amount = sleepiest[0].to_i32 * most_slept[1]
puts " ==> Part 1: #{amount.colorize(:green)}"

most_slept = guards.transform_values(&.zip(0...60).max_by(&.[0]))
  .max_by { |k, v| v[0] }
puts " ==> Part 1: #{(most_slept[0].to_i32 * most_slept[1][1]).colorize(:green)}"
