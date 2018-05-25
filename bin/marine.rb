#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

module ShippingForecast
  URL = 'https://www.metoffice.gov.uk/public/weather/marine/shipping-forecast'

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
  end

  class GeneralReport
    def initialize(nokogiri_node_set)
      @nokogiri_node_set = nokogiri_node_set
    end

    { issue_time: 'div', period: 'p' }.each do |sym, selector|
      define_method(sym) do
        elem = @nokogiri_node_set.css("#{selector}.#{StringUtils.camel_case(sym)}")
        StringUtils.stripped(elem.first.content)
      end
    end

    def general_situation
      general_situation = @nokogiri_node_set.css('h2')
      general_situation_content = general_situation.first.next_element
      StringUtils.stripped(general_situation_content.content)
    end

    def regions
      regions = @nokogiri_node_set.css('select#marineRegionSelect option')
      regions[1..-1].map(&:content) # remove all areas option
    end
  end

  class RegionalReport
    ATTRIBUTES = %i(wind sea_state weather visibility)

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
      section = nokogiri_doc.css('div.marineSection')
      GeneralReport.new(section)
    end

    def regional_report(region)
      regional = nokogiri_doc.css('div.cardContainer')
      region_node = regional.css("div[data-value=\"#{StringUtils.condense(region)}\"]")
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

print <<~EOR
  #{general_report.issue_time}
  #{general_report.period}

  #{general_report.general_situation}
  =============================================================================
  Wight

  #{regional_report.to_s}
EOR
# >> "Issued at: 04:05 on Fri 25 May 2018 UTC\nFor the period 06:00 on Fri 25 May 2018 UTC to 06:00 on Sat 26 May 2018 UTC\n\nHigh 150 miles west of Shannon 1033 expected Norwegian Basin 1035 by midnight tonight\n=============================================================================\nWight\n\nWind: Variable becoming northeasterly 3 or 4, occasionally 5 later.\nSea state: Smooth or slight becoming slight or moderate.\nWeather: Showers later, perhaps thundery, fog patches.\nVisibility: Moderate or good, occasionally very poor.\n"
