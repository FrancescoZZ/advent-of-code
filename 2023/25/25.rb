# frozen_string_literal: true

# rubocop:disable Lint
# rubocop:disable Metrics

# Node in undirected graph
class Node
  attr_accessor :node_count, :neighbors

  def initialize(node_count = 1, neighbors = [])
    @node_count = node_count
    @neighbors = neighbors
  end
end

input = File.open('input').read.split("\n")

def build_graph(data)
  data.each_with_object(Hash.new { |h, k| h[k] = Node.new }) do |line, hash|
    from, rest = line.split(': ')
    rest.split.each do |to|
      hash[from].neighbors << to
      hash[to].neighbors << from
    end
  end
end

def collapse(graph)
  while graph.size > 2
    u = graph.keys.sample
    v = graph[u].neighbors.sample
    graph[u].neighbors -= [v]
    graph[v].neighbors -= [u]
    graph[u].neighbors += graph[v].neighbors
    graph[u].node_count += graph[v].node_count
    graph[v].neighbors.each do |node|
      graph[node].neighbors -= [v]
      graph[node].neighbors += [u]
    end
    graph.delete(v)
  end

  graph
end

loop do
  new_graph = build_graph(input)
  size = new_graph.size
  collapsed_graph = collapse(build_graph(input))
  partition = collapsed_graph.first.last
  next unless partition.neighbors.size == 3

  puts partition.node_count * (size - partition.node_count)
  break
end
