# frozen_string_literal: true

input = File.open('input').read

reports = input.split("\n").map do |report|
  report.split.map(&:to_i)
end

safe = 0
reports.each do |report|
  trend = (report[1] - report[0]) <=> 0
  errors = 0
  report.each_cons(2) do |(a, b)|
    diff = b - a
    sign = diff <=> 0
    if diff.abs < 1 || diff.abs > 3 || sign != trend
      errors += 1
      break
    end
  end
  safe += 1 if errors.zero?
end

p safe
