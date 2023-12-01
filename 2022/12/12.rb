# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity

MOVES = [[0, 1], [0, -1], [-1, 0], [1, 0]].freeze

MAP = File.open('input')
          .read
          .split("\n")
          .map { _1.split('') }

Cell = Struct.new(:row, :col, :val, :steps, :explored)

def bfs(map, root, part)
  root.explored = true
  queue = [root]

  while queue.any?
    current = queue.shift
    return current.steps if current.val == 123

    MOVES.each do |dx, dy|
      new_row = current.row + dy
      new_col = current.col + dx

      new = map.dig(new_row, new_col)
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
  rows = MAP.length
  columns = MAP.first.length
  node_map = Array.new(rows) { Array.new(columns) }

  rows.times do |r|
    columns.times do |c|
      char = MAP[r][c]
      val = if char.ord.between?(97, 122)
              char.ord
            elsif char.eql? 'S'
              96
            elsif char.eql? 'E'
              123
            end
      node_map[r][c] = Cell.new(r, c, val, 0, false)
    end
  end

  root = node_map.flatten
                 .find { |c| c.val == 96 }

  bfs(node_map, root, part)
end

puts solve(1)
puts solve(2)
