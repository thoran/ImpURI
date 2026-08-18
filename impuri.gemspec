# impuri.gemspec

require_relative './lib/ImpURI/VERSION'

class Gem::Specification
  def development_dependencies=(gems)
    gems.each{|gem| add_development_dependency(*gem)}
  end
end

Gem::Specification.new do |spec|
  spec.name = 'impuri'
  spec.version = ImpURI::VERSION

  spec.summary = "This is a hand-written non-validating parser for URI's and ssh/scp almost URI resource descriptors."
  spec.description = "This is a hand-written non-validating parser for URI's and ssh/scp almost URI resource descriptors, which is intended to be cleaner and simpler than Ruby's standard URI."

  spec.author = 'thoran'
  spec.email = 'code@thoran.com'
  spec.homepage = 'https://github.com/thoran/ImpURI'
  spec.license = 'MIT'

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/thoran/ImpURI/issues',
    'changelog_uri' => 'https://github.com/thoran/ImpURI/blob/master/CHANGELOG',
    'source_code_uri' => 'https://github.com/thoran/ImpURI',
    'documentation_uri' => 'https://github.com/thoran/ImpURI/blob/master/README.md',
  }

  spec.required_ruby_version = '>= 2.7'
  spec.require_paths = ['lib']

  spec.files = [
    Dir['lib/**/*.rb'],
    Dir['test/**/*.rb'],
    'CHANGELOG',
    'Gemfile',
    'impuri.gemspec',
    'LICENSE',
    'Rakefile',
    'README.md',
    'TODO.txt',
  ].flatten

  spec.development_dependencies = [
    ['minitest', '~> 6.0'],
    ['rake'],
  ]
end
