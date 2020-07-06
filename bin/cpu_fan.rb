#!/usr/bin/env ruby

# frozen_string_literal: true

`sensors`.each_line do |line|
  next unless (match = /cpu_fan:[\s]*(?<rpm>[\d]+) RPM/.match line)

  rpm = match[:rpm].to_i
  puts "#{rpm} RPM"
end
