[![Build Status](http://img.shields.io/travis/pikesley/gitpaint.svg?style=flat-square)](https://travis-ci.org/pikesley/gitpaint)
[![Coverage Status](http://img.shields.io/coveralls/pikesley/gitpaint.svg?style=flat-square)](https://coveralls.io/r/pikesley/gitpaint)
[![Gem Version](http://img.shields.io/gem/v/gitpaint.svg?style=flat-square)](https://rubygems.org/gems/gitpaint)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://pikesley.mit-license.org)

# Gitpaint

Draw a grid of data onto the Github contributions graph

## Usage

```ruby
irb(main):001:0> require 'gitpaint'
=> true
irb(main):002:0> data = [[1] * 52, [1] + [0] * 50 + [1], [1] + [0] * 50 + [1], [1] + [0] * 50 + [1], [1] + [0] * 50 + [1], [1] + [0] * 50 + [1], [1] * 52]
=> [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]
irb(main):003:0> Gitpaint.paint data, '/path/to/existing/repo'
=> nil
irb(main):004:0>
```

### Notes

* the repo should already exist and have an `origin` remote on Github.
* the repo should be considered disposable, because Gitpaint will nuke it and start from scratch every time (it's just easier that way)
* the numbers in your data will be multiplied by `SCALE_FACTOR` (currently set to 8), so `[0, 1, 2]` becomes 0, 8, and 16 commits at each of those positions (larger numbers draw darker squares)
