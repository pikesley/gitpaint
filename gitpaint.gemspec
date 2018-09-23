
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitpaint/version'

Gem::Specification.new do |spec|
  spec.name          = 'gitpaint'
  spec.version       = Gitpaint::VERSION
  spec.authors       = ['pikesley']
  spec.email         = ['sam.pikesley@gmail.com']

  spec.summary       = %q{API for the Github Commit Graph}
  spec.description   = %q{Just because I can}
  spec.homepage      = 'http://pikesley.org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.16'
  spec.add_dependency 'nokogiri', '~> 1.8'
  spec.add_dependency 'git', '~> 1.5'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 4.0'
  spec.add_development_dependency 'webmock', '~> 3.4'
  spec.add_development_dependency 'timecop', '~> 0.9'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'pry', '~> 0.11'
end
