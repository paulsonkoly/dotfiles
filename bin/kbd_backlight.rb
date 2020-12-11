#!/usr/bin/env ruby
# frozen_string_literal: true

module KbdBacklight
  MODES = %w[off low med high].freeze

  module_function

  def index
    response = `sudo asusctl -k`
    MODES.find_index { |mode| response.include? mode }
  end

  def set(mode)
    `sudo asusctl -k #{mode}`
  end

  def up
    new = MODES[index + 1]
    set new
  end

  def down
    new = MODES[index - 1] if index.positive?
    set new if new
  end
end

case ARGV[0]
when 'up' then KbdBacklight.up
when 'down' then KbdBacklight.down
end
