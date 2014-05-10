# test/ImpURI.rb

gem 'minitest'

test_dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift(test_dir) unless $LOAD_PATH.include?(test_dir)

require 'ImpURI/class_methods'
require 'ImpURI/instance_methods'
