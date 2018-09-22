require 'date'

require 'httparty'
require 'nokogiri'

require 'gitpaint/version'

module Gitpaint
  def self.max_finder account
    url = 'https://github.com/users/contributions' % account
    response = HTTParty.get 'https://github.com/users/towers-of-hanoi/contributions'
    body = response.body
    doc = Nokogiri::HTML body
    data = doc.xpath '//rect/@data-count'
    data.map { |c| c.value.to_i }.max
  end

  def self.sunday_before_a_year_ago
    year_ago = (Date.today - 365)
    year_ago - year_ago.wday
  end

  def self.data_to_dates data
    current_date = sunday_before_a_year_ago
    dates = {}
    line = pad_grid(data).transpose.flatten

    line.each do |value|
      dates[current_date.iso8601] = value if value > 0
      current_date += 1
    end

    dates
  end

  def self.pad_row row
    row + [0] * (52 - row.count)
  end

  def self.pad_grid grid
    grid.map! { |row| pad_row row }
    until grid.count == 7
      grid.push [0] * 52
    end
    grid
  end
end
