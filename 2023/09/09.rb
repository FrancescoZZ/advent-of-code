# frozen_string_literal: true

# data = File.open('example')
data = File.open('input')
           .read
           .split("\n")
           .map { |l| l.split.map(&:to_i) }

# p data

def next_value(hst)
  differences = []
  hst.each_cons(2) do |(m, n)|
    differences << n - m
  end
  p differences
  hst.last + (differences.uniq.length == 1 ? differences.first : next_value(differences))
end

next_values = []
prev_values = []

data.each do |hst|
  p hst
  next_values << next_value(hst)
  prev_values << next_value(hst.reverse)
  p next_values.last
end

p next_values.sum
p prev_values.sum
