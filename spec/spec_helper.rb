require 'bundler/setup'
require 'gitpaint'
require 'timecop'
require 'coveralls'

Coveralls.wear!

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
