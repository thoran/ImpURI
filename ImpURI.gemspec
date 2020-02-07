Gem::Specification.new do |spec|
  spec.name = 'impuri'
  spec.version = '0.8.0'
  spec.date = '2020-02-07'

  spec.summary = "A cleaner and simpler URI and ssh/scp resource parser for Ruby."
  spec.description = "A cleaner and simpler URI and ssh/scp resource parser for Ruby.  Though I'm not sure about the simpler bit anymore.  It's now over 500 lines you know!"

  spec.author = 'thoran'
  spec.email = 'code@thoran.com'
  spec.homepage = 'http://github.com/thoran/ImpURI'
  spec.license = 'MIT'

  spec.files = Dir['lib/**/*.rb']
  spec.has_rdoc = false
  spec.required_ruby_version = '>= 1.8.6'
end
