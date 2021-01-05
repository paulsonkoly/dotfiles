#!/usr/bin/env ruby

# frozen_string_literal: true

require 'sys/proctable'
require 'i3ipc'

module Weechat
  CMDLINE = "termite -t weechat -e 'ssh -tp44422 phaul@sdd.hu screen -r'"
  CMDLINE_MATCH = 'termite -t weechat'

  class << self
    def running?
      Sys::ProcTable.ps.any? do |process|
        process.cmdline.start_with? CMDLINE_MATCH
      end
    end

    def run!
      Process.exec(CMDLINE)
    end
  end
end

i3 = I3Ipc::Connection.new
i3.command('workspace 3: chat')
i3.close

Weechat.run! unless Weechat.running?
