require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.ruby_opts = "-w"
end

require "rubocop/rake_task"
RuboCop::RakeTask.new

require "cane/rake_task"
Cane::RakeTask.new do |t|
  t.no_doc = true
  t.style_measure = 120
  t.abc_max = 20
end

task default: %i[spec rubocop cane]
