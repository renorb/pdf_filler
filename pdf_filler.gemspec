# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pdf_filler}
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wes Hays", "Darrne Johnson"]
  s.date = %q{2009-08-08}
  s.description = %q{PDF Filler makes it easy to file your PDFs.}
  s.email = ["weshays@gbdev.com", "djohnson@gbdev.com"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "Rakefile",
     "init.rb",
     "lib/iText-2.1.7.jar",
     "lib/pdf_filler.rb",
     "lib/pdf_filler/book.rb",
     "lib/pdf_filler/page.rb",
     "lib/pdf_filler/pdf_db_mapper.rb",
     "lib/pdf_filler/util_methods.rb",
     "spec/lib/pdf_book_spec.rb",
     "spec/lib/pdf_db_mapper_spec.rb",
     "spec/lib/pdf_page_spec.rb",
     "spec/spec_helper.rb",
     "spec/templates/certificate_template.pdf",
     "tasks/build_gem.rake",
     "tasks/documentation.rake"
  ]
  s.homepage = %q{http://wiki.github.com/gbdev/pdf-filler}
  s.rdoc_options = ["--charset=UTF-8", "--title", "pdf_filler", "--main", "README.rdoc", "--line-numbers", "--inline-source"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A Rails plugin to fill a PDF form using RJB and iText.}
  s.test_files = [
    "spec/lib/pdf_page_spec.rb",
     "spec/lib/pdf_book_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rjb>, [">= 1.1.7"])
    else
      s.add_dependency(%q<rjb>, [">= 1.1.7"])
    end
  else
    s.add_dependency(%q<rjb>, [">= 1.1.7"])
  end
end
