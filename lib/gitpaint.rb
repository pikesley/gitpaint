require 'date'
require 'fileutils'

require 'httparty'
require 'nokogiri'
require 'git'

require 'gitpaint/version'

module Gitpaint
  SCALE_FACTOR = 8

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
    if Date.today.strftime('%A') == 'Sunday'
      return Date.today - 364
    end
    year_ago - year_ago.wday
  end

  def self.github_user repo
    Git.init(repo).config['user.name']
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

    until grid.count >= 7
      grid.push [0] * 52
    end
    grid
  end

  def self.scale_grid grid
    grid.map { |row| row.map { |v| v * SCALE_FACTOR } }
  end

  def self.make_commit date, message: 'The commit is a lie'
    'GIT_AUTHOR_DATE=%sT12:00:00 GIT_COMMITTER_DATE=%sT12:00:00 git commit --allow-empty -m "%s" > /dev/null' % [
      date,
      date,
      message
    ]
  end

  def self.paint data, repo, nuke: true, push: true
    nuke repo if nuke

    unless data.flatten.uniq.delete_if { |i| i == 0 } == []
      Dir.chdir repo
      data = scale_grid data
      dates = data_to_dates data
      dates.each_pair do |date, count|
        count.times do
          s = Gitpaint.make_commit date
          `#{s}`
        end
      end
    end

    push_commits repo if push
  end

  def self.nuke repo
    g = Git.init repo
    remote = g.remote.url
    FileUtils.rm_rf "#{g.dir.path}/.git"
    g = Git.init repo
    g.add_remote 'origin', remote
    Dir.chdir repo
    s = make_commit '1970-01-01', message: 'Ancient commit'
    `#{s}`
  end

  def self.push_commits repo
    g = Git.init repo
    g.push 'origin', 'master', f: true
  end
end
