[![Build Status](http://img.shields.io/travis/pikesley/gitpaint.svg?style=flat-square)](https://travis-ci.org/pikesley/gitpaint)
[![Coverage Status](http://img.shields.io/coveralls/pikesley/gitpaint.svg?style=flat-square)](https://coveralls.io/r/pikesley/gitpaint)
[![Gem Version](http://img.shields.io/gem/v/gitpaint.svg?style=flat-square)](https://rubygems.org/gems/gitpaint)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://pikesley.mit-license.org)

# Gitpaint

Draw a grid of data onto the Github contributions graph

## Installation

    git clone https://github.com/pikesley/gitpaint
    cd gitpaint
    bundle
    bundle exec rake
    bundle exec rake install

## Configuration

    Gitpaint.configure do |config|
      config.username = github_user
      config.email =    github_email
      config.repo =     github_repo
      config.token =    github_api_token
      config.ssh_key =  /path/to/ssh_key
    end

### About the configuration

* Github only credits you with a contribution if the commit (apparently) came from the username and email associated with your account, so we need those
* We also need a (disposable) repo to work with: this will be created locally at `/tmp/#{repo}` and remotely at `https://github.com/#{github_user}/#{repo}` (and it will be mercilessly deleted from both places between runs)
* We need a Github [personal access token](https://github.com/settings/tokens) that has the `repo` privileges and, crucially, the separate `delete repo` privilege
* And we need the path to an ssh key that can commit to the `#{github_user}` account

## Painting

    data = [
      [3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3],
      [3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3],
      [2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 0, 1, 0, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 3],
      [2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 2, 2, 2, 1, 2, 2, 1, 1, 1, 2, 3, 3, 3, 2, 2, 3, 2, 2, 2, 2, 2, 2],
      [2, 2, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 2, 3, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 2, 2, 1, 1, 1, 1, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
      [2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 2, 3, 2, 2, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 2, 2, 1, 0, 1, 1, 1, 0, 0, 1, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 1, 1],
      [2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 2, 2, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 2, 2, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ]
    Gitpaint.paint data

### Rendering from a PNG

There's some slightly clunky code that will take a 52*7 greyscale PNG image and turn it into data suitable for Gitpaint. Use it like

    pngr = Gitpaint::PNGRenderer.new 'image.png'

or

    bundle exec rake image:decompose[image.png]

the pass that to `Gitpaint.paint`
