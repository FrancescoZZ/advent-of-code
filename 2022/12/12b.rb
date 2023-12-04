# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize

require 'set'

DATA = File.open('input')
           .read
           .split("\n")
           .map { _1.split('') }

ROWS = DATA.length
COLUMNS = DATA.first.length

MOVES = [[0, 1], [0, -1], [-1, 0], [1, 0]].freeze

def bfs(graph, root, part)
  explored = Set.new([root])
  queue = [[root, 0]]

  while queue.any?
    current, steps = queue.shift
    row, col = current
    steps = 0 if DATA[row][col] == 'a' && part == 2
    return steps if DATA[row][col] == 'E'

    graph[current].each do |neighbor|
      next if explored.include?(neighbor)

      explored.add(neighbor)
      queue << [neighbor, steps + 1]
    end
  end
end

def elevation(str)
  case str
  when 'S' then 0
  when 'E' then 27
  else 1 + str.ord - 'a'.ord
  end
end

def index_in_bounds?(row, col)
  row.between?(0, ROWS - 1) &&
    col.between?(0, COLUMNS - 1)
end

def valid?(row, col, r_new, c_new)
  return false unless index_in_bounds?(r_new, c_new)

  current = elevation(DATA[row][col])
  new = elevation(DATA[r_new][c_new])

  new - current <= 1
end

def neighbors(row, col)
  neighbors = []
  MOVES.each do |dx, dy|
    r_new = row + dy
    c_new = col + dx
    next unless valid?(row, col, r_new, c_new)

    neighbors << [r_new, c_new]
  end
  neighbors
end

def build_graph
  node_graph = {}

  DATA.each_with_index do |row, r|
    row.each_with_index do |_, c|
      node_graph[[r, c]] = neighbors(r, c)
    end
  end

  node_graph
end

def solve(part)
  node_graph = build_graph
  root = node_graph.keys.find { |r, c| DATA[r][c] == 'S' }

  bfs(node_graph, root, part)
end

puts solve(1)
puts solve(2)
