# data = File.open('example').read
data = File.open('input').read
seeds = data.split("\n\n")[0].split(': ')[1].split.map(&:to_i)

# Part 1
charts = data.split("\n\n")[1..]
             .map { |chart| chart.split("\n")[1..].map { |l| l.split.map(&:to_i) } }

locations = []

def next_category(seed, chart)
  chart.each do |line|
    d_start, s_start, s_len = line
    return d_start + seed - s_start if seed.between? s_start, s_start + s_len - 1
  end

  seed
end

def convert(seed, charts)
  charts.each do |chart|
    seed = next_category(seed, chart)
  end

  seed
end

seeds.each do |seed|
  seed = convert(seed, charts)
  locations << seed
end

puts locations.min

# Part 2
seed_ranges = seeds.each_slice(2).to_a

def reverse(value, reversed)
  reversed.each do |chart|
    chart.each do |line|
      if value.between?(line[0], line[0] + line[2] - 1)
        value = value - line[0] + line[1]
        break
      end
    end
  end

  value
end

location = 0

loop do
  value = reverse(location, charts.reverse)
  seed_ranges.each do |range|
    if value.between? range.first, range.first + range.last - 1
      puts location
      exit
    end
  end

  location += 1
end
