require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name    = 'pdf_filler'
    gem.version = '0.1.0'
    gem.date    = '2009-08-25'

    gem.summary = "A Rails plugin to fill a PDF form using RJB and iText."
    gem.description = "PDF Filler makes it easy to file your PDFs."

    gem.authors  = ['Reno Ruby Group']
    gem.email    = ['renorb@renorb.org']
    gem.homepage = 'http://wiki.github.com/renorb/pdf_filler'

    gem.has_rdoc = true
    gem.rdoc_options << '--title' << gem.name << '--main' << 'README.rdoc' << '--line-numbers' << '--inline-source'
    gem.extra_rdoc_files = ['README.rdoc']

    gem.files = ['LICENSE', 
                 'README.rdoc',
                 'Rakefile',
                 'init.rb',
                 'lib/iText-2.1.7.jar',
                 'lib/pdf_filler.rb',
                 'lib/pdf_filler/page.rb',
                 'lib/pdf_filler/book.rb',
                 'lib/pdf_filler/pdf_db_mapper.rb',
                 'lib/pdf_filler/util_methods.rb',
                 'tasks/documentation.rake',
                 'tasks/build_gem.rake',
                 'spec/spec_helper.rb',
                 'spec/lib/pdf_page_spec.rb',
                 'spec/lib/pdf_book_spec.rb',
                 'spec/lib/pdf_db_mapper_spec.rb',
                 'spec/output',
                 'spec/templates/certificate_template.pdf']

    gem.test_files = ['spec/lib/pdf_page_spec.rb',
                      'spec/lib/pdf_book_spec.rb']    
    
    gem.add_dependency 'rjb', '>= 1.1.7'
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end