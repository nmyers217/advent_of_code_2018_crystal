require "colorize"
require "string_scanner"
require "../aoc.cr"

struct Claim
  property id : Int32
  property x : Int32
  property y : Int32
  property width : Int32
  property height : Int32

  def initialize(@id, @x, @y, @width, @height)
  end

  def initialize(str : String)
    regex = /#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/
    s = StringScanner.new(str)
    s.scan(regex)
    @id = s["id"].to_i32
    @x = s["x"].to_i32
    @y = s["y"].to_i32
    @width = s["width"].to_i32
    @height = s["height"].to_i32
  end
end

enum State
  Empty
  Claim
  Conflict
end

FABRIC_DIM = 1000

struct Fabric
  @width = FABRIC_DIM
  @height = FABRIC_DIM
  @squareInches : Array(Array(State))

  def initialize
    @squareInches = (0...@height).map do |y|
      (0...@width).map { |x| State::Empty }
    end
  end

  def makeClaim(c : Claim)
    (0...c.height).each do |dy|
      (0...c.width).each do |dx|
        curState = @squareInches[c.y + dy][c.x + dx]
        nextState = curState == State::Empty ? State::Claim : State::Conflict
        @squareInches[c.y + dy][c.x + dx] = nextState
      end
    end
  end

  def goodClaim?(c : Claim)
    goodClaim = true
    (0...c.height).each do |dy|
      (0...c.width).each do |dx|
        curState = @squareInches[c.y + dy][c.x + dx]
        return false if curState == State::Conflict
      end
    end
    goodClaim
  end

  def countConflicts
    result = 0
    @squareInches.each do |row|
      row.each do |col|
        result += 1 if col == State::Conflict
      end
    end
    result
  end
end

class Day3 < Problem
  @claims : Array(Claim)

  def initialize
    @claims = [] of Claim
  end

  def parse_input(filePath)
    puts "#{"* Reading file".colorize(:yellow)}: #{filePath}..."
    @claims = File.read_lines(filePath).map { |line| Claim.new(line) }
    puts " ==> Loaded..."
    puts " ==> Beginning: #{@claims[0..1]}..."
    puts " ==> End: #{@claims[@claims.size - 2..]}..."
    self
  end

  def solve
    puts "#{"* Solving".colorize(:yellow)}: #{__FILE__}..."

    f = Fabric.new

    @claims.map { |c| f.makeClaim c }
    puts " ==> Part 1: #{f.countConflicts.colorize(:green)}"

    goodClaims = @claims.each.select { |c| f.goodClaim? c }
    puts " ==> Part 2: #{goodClaims.first.id.colorize(:green)}"
  end
end
