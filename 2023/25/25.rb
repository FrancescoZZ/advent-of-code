# frozen_string_literal: true

# rubocop:disable Metrics

# Node in undirected graph
class Node
  attr_accessor :node_count, :neighbors

  def initialize(node_count = 1, neighbors = [])
    @node_count = node_count
    @neighbors = neighbors
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

  graph.values
end

graph = File.open('input').read.split("\n")
            .each_with_object(Hash.new { |h, k| h[k] = Node.new }) do |line, hash|
  from, rest = line.split(': ')
  rest.split.each do |to|
    hash[from].neighbors << to
    hash[to].neighbors << from
  end
end
graph.default = nil

loop do
  new_graph = Marshal.load(Marshal.dump(graph))
  partition1, partition2 = collapse(new_graph)
  next unless partition1.neighbors.size == 3

  puts partition1.node_count * partition2.node_count
  break
end
