# frozen_string_literal: true

# rubocop:disable Metrics

require 'set'

DATA = File.open('input')
           .read
           .split("\n")
           .map(&:chars)

ROWS = DATA.length
COLUMNS = DATA.first.length

MOVES = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze

def bfs(graph, root, limit)
  final = Set.new
  explored = Set.new([root])
  queue = [[root, 0]]
  while queue.any?
    current, steps = queue.shift
    final << current if steps <= limit && steps.even?
    next if steps == limit

    graph[current].each do |neighbor|
      next if explored.include?(neighbor)

      explored << neighbor
      queue << [neighbor, steps + 1]
    end
  end
  final.size
end

def in_bounds?(row, col)
  row.between?(0, ROWS - 1) &&
    col.between?(0, COLUMNS - 1)
end

def neighbors(row, col)
  MOVES.each_with_object([]) do |(dr, dc), arr|
    nr = row + dr
    nc = col + dc

    next unless in_bounds?(nr, nc) && DATA[nr][nc] != '#'

    arr << [nr, nc]
  end
end

def build_graph
  DATA.each_with_index.with_object({}) do |(row, r), hash|
    row.each_with_index do |_, c|
      hash[[r, c]] = neighbors(r, c)
    end
  end
end

node_graph = build_graph
root = DATA.flatten.index('S').divmod(COLUMNS)
p bfs(node_graph, root, 64)
