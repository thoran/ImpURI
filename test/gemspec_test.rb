# test/gemspec_test.rb

gem 'minitest'

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require 'impuri'
require 'minitest/autorun'

describe 'impuri.gemspec' do
  let(:spec){Gem::Specification.load(File.expand_path('../impuri.gemspec', __dir__))}

  it "is a valid specification" do
    _(spec.validate).must_equal(true)
  end

  it "does not pin a date" do
    _(spec.date).must_equal(Gem::Specification.new.date)
  end

  it "takes its version from ImpURI::VERSION" do
    _(spec.version.to_s).must_equal(ImpURI::VERSION)
  end

  it "declares the metadata links rubygems shows beside the gem" do
    _(spec.metadata.keys.sort) \
      .must_equal(%w{bug_tracker_uri changelog_uri documentation_uri source_code_uri})
  end

  it "points its metadata at the branch which exists" do
    _(spec.metadata.values.grep(%r{/blob/})).wont_be_empty
    _(spec.metadata.values.grep(%r{/blob/(?!master/)})).must_equal([])
  end

  it "declares no runtime dependencies, the library standing alone" do
    _(spec.runtime_dependencies).must_equal([])
  end

  it "declares its development dependencies" do
    _(spec.development_dependencies.map(&:name).sort).must_equal(%w{minitest})
  end
end
