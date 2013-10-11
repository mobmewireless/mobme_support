require 'rspec/core/rake_task'
require 'rake/tasklib'
require 'ci/reporter/rake/rspec'
require 'yard'
require 'yard/rake/yardoc_task'

RSpec::Core::RakeTask.new(spec: %w(ci:setup:rspec)) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

task default: :spec

desc 'Analyze for code complexity with metric_fu'
task :metrics do
  if system 'bundle exec metric_fu -r'
    puts "\nOpen up 'tmp/metric_fu/output/index.html' in your browser to see results."
  end
end

YARD::Rake::YardocTask.new(:yard) do |y|
  y.options = %w(--output-dir yardoc)
end
