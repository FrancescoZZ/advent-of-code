# frozen_string_literal: true

require 'benchmark'

data = File.open('input')
           .read

node_list = data.split("\n\n")[1]

n = 10_000

Benchmark.bmbm do |x|
  x.report('reduce') do
    n.times do
      node_list.split("\n")
               .map { |l| l.scan(/\w+/) }
               .reduce({}) { |hash, (k, l, r)| hash.update(k => { 'L' => l, 'R' => r }) }
    end
  end
  x.report('each') do
    n.times do
      hash = {}
      node_list.split("\n")
               .map { |l| l.scan(/\w+/) }
               .each { |(k, l, r)| hash[k] = { 'L' => l, 'R' => r } }
    end
  end
  x.report('each_with_object') do
    n.times do
      node_list.split("\n")
               .map { |l| l.scan(/\w+/) }
               .each_with_object({}) { |(k, l, r), hash| hash[k] = { 'L' => l, 'R' => r } }
    end
  end
end

# Rehearsal ----------------------------------------------------
# reduce            26.312247   0.070423  26.382670 ( 26.384034)
# each              26.309364   0.096068  26.405432 ( 26.409361)
# each_with_object  26.222575   0.068193  26.290768 ( 26.292186)
# ------------------------------------------ total: 79.078870sec

#                        user     system      total        real
# reduce            25.660176   0.070681  25.730857 ( 25.732032)
# each              25.305027   0.067534  25.372561 ( 25.374183)
# each_with_object  25.328194   0.066952  25.395146 ( 25.396386)
