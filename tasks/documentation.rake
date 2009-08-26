require 'rubygems'
require 'rake/rdoctask'

desc 'Generate documentation for PDF-Filler.'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc/html'
  rdoc.title    = 'pdf_filler'  
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.main = 'README.rdoc'
  rdoc.rdoc_files.include('LICENSE', 'lib/')
end


begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    t.test_files = Dir[ "spec/**/*_spec.rb" ]
  end
rescue LoadError
  nil
end

begin
  require 'rcov/rcovtask'
  desc 'Runs spec:rcov and then displays the coverage/index.html file in the browser.' 
  task :rcov_display => [:clobber_rcov, :rcov] do 
    system("open coverage/index.html")
  end
rescue LoadError
  nil
end

