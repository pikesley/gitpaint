require 'date'
require 'fileutils'
require 'singleton'

require 'httparty'
require 'nokogiri'
require 'git'
require 'octokit'

require 'gitpaint/version'
require 'gitpaint/github_client'
require 'gitpaint/config'

module Gitpaint
  def self.github_client
    GithubClient.instance.client
  end

  def self.configure
    yield Config.instance.config
  end

  def self.config
    Config.instance.config
  end

  def self.sunday_before_a_year_ago
    year_ago = (Date.today - 365)
    if Date.today.strftime('%A') == 'Sunday'
      return Date.today - 364
    end
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

    until grid.count >= 7
      grid.push [0] * 52
    end
    grid
  end

  def self.scale_commits grid
    grid.map { |row| row.map { |v| v * config.scale_factor } }
  end

  def self.make_commit date, message: 'The commit is a lie'
    pieces = []

    pieces.push "GIT_AUTHOR_NAME=%s" % config.username
    pieces.push "GIT_AUTHOR_EMAIL=%s" % config.email
    pieces.push "GIT_AUTHOR_DATE=%sT12:00:00" % date
    pieces.push "GIT_COMMITTER_NAME=%s" % config.username
    pieces.push "GIT_COMMITTER_EMAIL=%s" % config.email
    pieces.push "GIT_COMMITTER_DATE=%sT12:00:00" % date

    "%s git commit --allow-empty -m '%s' > /dev/null" % [
      pieces.join(' '),
      message
    ]
  end

  def self.paint data, repo, message: config.commit_message 
    clean_local repo
    nuke repo

    unless data.flatten.uniq.delete_if { |i| i == 0 } == []
      remote = create repo
      custom_ssh_script
      Git.configure do |config|
        config.git_ssh = '/tmp/custom.sh'
      end

      g = Git.init "/tmp/#{repo}"
      g.add_remote 'origin', remote

      make_commits data, repo, message: message

      push repo
    end
  end

  def self.make_commits data, repo, message:
    FileUtils.chdir "/tmp/#{repo}"
    data = scale_commits data
    dates = data_to_dates data
    dates.each_pair do |date, count|
      count.times do
        s = Gitpaint.make_commit date, message: message
        `#{s}`
      end
    end
  end

  def self.clean_local repo
    FileUtils.rm_rf "/tmp/#{repo}"
  end

  def self.nuke repo
    begin
      victim = github_client.repos.select { |r| r.name == repo }.first.id
      github_client.delete_repository victim
    rescue NoMethodError => e
      # do something here
    end
  end

  def self.custom_ssh_script dir = '/tmp'
    File.open "#{dir}/custom.sh", 'w' do |f|
      f.write "#!/bin/sh\n"
      f.write 'ssh -i "%s" "$@"' % config.ssh_key
    end
    FileUtils.chmod '+x', "#{dir}/custom.sh"
  end

  def self.create repo
    r = github_client.create_repository repo
    r.ssh_url
  end

  def self.push repo
    g = Git.open "/tmp/#{repo}"
    g.push 'origin', 'master'
  end
end
