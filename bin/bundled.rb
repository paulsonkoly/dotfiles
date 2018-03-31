#!/usr/bin/env ruby
# Outputs the tags file locations from all gems accessible from the current
# bundle Gemfile. This code is called from a vim function that sets the tags
# vim option based on this. Calling Bundler.load directly from vim was messing
# up the state inside vim resulting in gems like xmpfilter outside of the
# current bundle to fail.
#
# Tags files are expected to be located under the gem root. To achieve this
# one can install ripper-tags and gem-ripper-tags. Then execute bundle exec
# gem ripper_tags under the bundle root.

require 'bundler'

begin
  print Bundler.load.specs.map { |e| File.join(e.full_gem_path, 'tags') }.join(',')
rescue Bundler::BundlerError
rescue Gem::Exception
end
