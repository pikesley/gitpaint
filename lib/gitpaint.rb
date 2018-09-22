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
end
