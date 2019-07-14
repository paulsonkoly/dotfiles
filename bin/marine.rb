#!/usr/bin/env ruby
# frozen_string_literal: true

# A small program started from polybar, to show uk shipping forecasts
# Copyright © 2018 Paul Sonkoly

# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
# OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'nokogiri'
require 'open-uri'
require 'libnotify'

module ShippingForecast
  URL = 'https://www.metoffice.gov.uk/weather/specialist-forecasts/coast-and-sea/shipping-forecast'

  module StringUtils
    def self.capitalize(str)
      str.to_s.tr('_', ' ').capitalize
    end

    def self.camel_case(str)
      ary = str.to_s.split('_')
      ary[0] << ary[1..-1].map(&:capitalize).join
    end

    def self.condense(str)
      str.to_s.delete(' ').downcase
    end

    def self.stripped(str)
      str.to_s.gsub(/\n */, ' ').strip
    end

    def self.dashize(str)
      str.to_s.gsub('_', '-')
    end
  end

  class GeneralReport
    def initialize(nokogiri_node_set)
      @nokogiri_node_set = nokogiri_node_set
    end

    %w(synopsis_time synopsis_text).each do |sym|
      define_method(sym) do
        sel = StringUtils.dashize(sym)
        elem = @nokogiri_node_set.css("p.#{sel}")
        StringUtils.stripped(elem.first.content)
      end
    end

    alias synopsis synopsis_text 

    def sea_forecast_time
      ps = @nokogiri_node_set.css("div#sea-forecast-time>p").map(&:content)
      StringUtils.stripped(ps[0]) + "\n" + StringUtils.stripped(ps[1])
    end
  end

  class RegionalReport
    ATTRIBUTES = %i(wind sea_state weather visibility).freeze

    def initialize(nokogiri_node_set)
      @nokogiri_node_set = nokogiri_node_set
    end

    ATTRIBUTES.each do |sym|
      define_method(sym) do
        capitalized = StringUtils.capitalize(sym)
        title = @nokogiri_node_set.css("dt:contains(\"#{capitalized}\")")
        title.first.next_element.content
      end
    end

    def to_s
      ATTRIBUTES.map do |attr|
        "#{StringUtils.capitalize(attr)}: #{send(attr)}"
      end.join("\n")
    end
  end

  class << self
    def general_report
      section = nokogiri_doc.css('div#summary')
      GeneralReport.new(section)
    end

    def regional_report(region)
      region_node = nokogiri_doc.css("div.marine-card##{StringUtils.condense(region)}")
      RegionalReport.new(region_node)
    end

    private

    def nokogiri_doc
      @nokogiri_doc ||= get_nokogiri_doc
    end

    def get_nokogiri_doc
      open(URL) do |f|
        return Nokogiri::HTML(f)
      end
    end
  end
end

general_report = ShippingForecast.general_report
regional_report = ShippingForecast.regional_report('wight')

Libnotify.new do |notify|
  notify.summary = 'Shipping forecast'
  notify.body = <<~EOR
    #{general_report.synopsis_time}\n
    #{general_report.sea_forecast_time}\n
    #{general_report.synopsis}\n

    ===================================

    Wight
    #{regional_report}
  EOR
end.show!
