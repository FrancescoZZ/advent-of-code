# data = File.open('example').read
data = File.open('input').read
seeds = data.split("\n\n")[0].split(': ')[1].split.map(&:to_i)
charts = data.split("\n\n")[1..]
             .map { |chart| chart.split("\n")[1..].map { |l| l.split.map(&:to_i) } }

locations = []

def convert(seed, chart)
  chart.each do |line|
    d_start, s_start, s_len = line
    return d_start + seed - s_start if seed.between? s_start, s_start + s_len - 1
  end

  seed
end

seeds.each do |seed|
  charts.each do |chart|
    seed = convert(seed, chart)
  end
  locations << seed
end

puts locations.min
