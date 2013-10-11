require "simplecov"
require "simplecov-rcov"

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start do
  add_filter 'vendor'
  add_filter 'spec'
end if ENV['COVERAGE']
