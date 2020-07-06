#!/usr/bin/env ruby

# frozen_string_literal: true

def normalize(float)
  float.fdiv(1024).round(2)
end

File.open('/proc/cpuinfo') do |io|
  loop do
    min, max = Float::MAX, 0
    io.each_line do |line|
      next unless (match = /cpu MHz[\s]*: (?<freq>[\d.]+)/.match(line))

      freq = match[:freq].to_f
      min = freq if freq < min
      max = freq if freq > min
    end
    puts "#{normalize(min)} GHz - #{normalize(max)} GHz"
    STDOUT.flush
    io.rewind
    sleep 5
  end
end
