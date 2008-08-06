task :default => :rcov

desc 'Run coverage analysis'
task :rcov do
  system "rcov --xrefs --exclude 'Library' test/*.rb"
  system "open coverage/index.html"
end