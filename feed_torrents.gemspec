require File.expand_path('../lib/feed_torrents/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "feed_torrents"
  gem.version       = FeedTorrents::VERSION
  gem.summary       = %q{Follow configurable feeds and download torrents, even from magnet urls}
  gem.description   = %q{Follow configurable feeds and download torrents, even from magnet urls}
  gem.license       = "MIT"
  gem.authors       = ["Tom van Leeuwen"]
  gem.email         = "tom@vleeuwen.eu"
  gem.homepage      = "https://rubygems.org/gems/feed_torrents"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'awesome_print', '~> 1.6'

  gem.add_development_dependency 'bundler', '~> 1.5'
  gem.add_development_dependency 'rake', '~> 10.4'
  gem.add_development_dependency 'rdoc', '~> 4.1'
  gem.add_development_dependency 'rspec', '~> 3.1'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
