require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ruby-duration"
    gem.summary = %Q{Duration type}
    gem.description = %Q{Duration type}
    gem.email = "jose@peleteiro.net"
    gem.homepage = "http://github.com/peleteiro/duration"
    gem.authors = ["Jose Peleteiro"]
    gem.add_development_dependency "minitest", ">= 0"
    gem.add_development_dependency "yard", ">= 0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.rcov_opts << %w{--exclude /Library,.bundle,test,gems,.rvm}
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

namespace(:test) do
  desc "Run tests on multiple ruby versions"
  task(:portability) do
    versions = %w{system 1.8.7 ree-1.8.7 1.9.2 jruby rubinius}
    versions.each do |version|
      system <<-BASH
        bash -c 'source ~/.rvm/scripts/rvm;
                 rvm use #{version};
                 echo "-------- `ruby -v` ---------\n";
                 gem install jeweler activesupport minitest yard i18n
                 rake -s test'
      BASH
    end
  end
end

task :test => :check_dependencies

task :default => :test

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
