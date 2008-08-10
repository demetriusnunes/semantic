task :default => :test

desc 'Run all tests'
task :test do 
  Dir['test/**/*.rb'].all? do |file|
    system("ruby #{file}")
  end or raise "Failures"
end
  
desc 'Run coverage analysis'
task :rcov do
  system "rcov --xrefs --exclude 'Library' test/*.rb"
  system "open coverage/index.html" if RUBY_PLATFORM =~ /darwin/
  system "firefox coverage/index.html" if RUBY_PLATFORM =~ /linux/
end

task :default => :test


