#!/usr/bin/env ruby

# frozen_string_literal: true

require 'sys/proctable'
require 'i3ipc'

module Firefox
  EXECUTABLE = '/usr/lib/firefox/firefox'

  class << self
    def running?
      Sys::ProcTable.ps.any? do |process|
        process.cmdline.start_with? EXECUTABLE
      end
    end

    def run!
      Process.exec(EXECUTABLE)
    end
  end
end

i3 = I3Ipc::Connection.new
i3.command('workspace 9: www')
i3.close

Firefox.run! unless Firefox.running?
