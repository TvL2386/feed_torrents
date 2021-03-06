require File.expand_path('../lib/feed_torrents/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'feed_torrents'
  gem.version       = FeedTorrents::VERSION
  gem.summary       = %q{A (multi) torrent feed reader without gui that handles both torrent links and magnet links downloading them as torrents}
  gem.description   = %q{A (multi) torrent feed reader without gui that handles both torrent links and magnet links downloading them as torrents}
  gem.license       = 'MIT'
  gem.authors       = ['Tom van Leeuwen']
  gem.email         = 'tom@vleeuwen.eu'
  gem.homepage      = 'https://github.com/TvL2386/feed_torrents'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'eventmachine', '~> 1.0'
  gem.add_dependency 'simple-rss', '~> 1.3'
  gem.add_dependency 'em-http-request', '~> 1.1'
  gem.add_dependency 'term-ansicolor', '~> 1.3'
  gem.add_dependency 'mail', '~> 2.6'

  gem.add_development_dependency 'bundler', '~> 1.5'
  gem.add_development_dependency 'rake', '~> 10.4'
  gem.add_development_dependency 'rdoc', '~> 4.1'
  gem.add_development_dependency 'rspec', '~> 3.1'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
