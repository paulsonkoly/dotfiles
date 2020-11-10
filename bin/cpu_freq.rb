#!/usr/bin/env ruby

# frozen_string_literal: true

class Ramp
  RAMPSTRING = '▁▂▃▄▅▆▇█'

  def initialize(min, max)
    @min = min
    @max = max
  end

  def for_values(*values)
    values.map { |value| for_value(value) }.join
  end

  private

  def for_value(value)
    RAMPSTRING[indexify(value)]
  end

  def indexify(value)
    return 0 if value < @min

    (value - @min) / range.fdiv(RAMPSTRING.length)
  end

  def range
    @max - @min
  end
end

ramp = Ramp.new(1200, 3800) # khz

File.open('/proc/cpuinfo') do |io|
  loop do
    # min, max = Float::MAX, 0
    frequencies = io.each_line.map do |line|
      next unless (match = /cpu MHz[\s]*: (?<freq>[\d.]+)/.match(line))

      match[:freq].to_f
    end.compact
    puts ramp.for_values(*frequencies)
    STDOUT.flush
    io.rewind
    sleep 3
  end
end
