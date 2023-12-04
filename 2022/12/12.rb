# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity

MOVES = [[0, 1], [0, -1], [-1, 0], [1, 0]].freeze

GRAPH = File.open('input')
            .read
            .split("\n")
            .map { _1.split('') }

Node = Struct.new(:row, :col, :val, :steps, :explored)

def bfs(graph, root, part)
  root.explored = true
  queue = [root]

  while queue.any?
    current = queue.shift
    return current.steps if current.val == 123

    MOVES.each do |dx, dy|
      new_row = current.row + dy
      new_col = current.col + dx

      new = graph.dig(new_row, new_col)
      next unless new_row >= 0 &&
                  new_col >= 0 &&
                  new &&
                  new.val - current.val <= 1 &&
                  !new.explored

      new.explored = true
      new.steps = new.val == 97 && part == 2 ? 0 : current.steps + 1
      queue << new
    end
  end
end

def solve(part)
  rows = GRAPH.length
  columns = GRAPH.first.length
  node_graph = Array.new(rows) { Array.new(columns) }

  rows.times do |r|
    columns.times do |c|
      char = GRAPH[r][c]
      val = if char.ord.between?(97, 122)
              char.ord
            elsif char.eql? 'S'
              96
            elsif char.eql? 'E'
              123
            end
      node_graph[r][c] = Node.new(r, c, val, 0, false)
    end
  end

  root = node_graph.flatten
                   .find { |c| c.val == 96 }

  bfs(node_graph, root, part)
end

puts solve(1)
puts solve(2)
