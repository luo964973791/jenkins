require 'rbconfig'
# ruby 1.8.7 doesn't define RUBY_ENGINE
ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
ruby_version = RbConfig::CONFIG["ruby_version"]
path = File.expand_path('..', __FILE__)
$:.unshift File.expand_path("#{path}/../gems/json-1.8.1-java/lib")
$:.unshift File.expand_path("#{path}/../gems/slop-3.0.4/lib")
$:.unshift File.expand_path("#{path}/../gems/jenkins-plugin-runtime-0.2.3/lib")
