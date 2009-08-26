require 'fileutils'
require 'rjb'

load_path = File.expand_path(File.dirname(__FILE__) + '/iText-2.1.7.jar')
options = ['-Djava.awt.headless=true'] 
Rjb::load load_path, options

FileOutputStream      = Rjb::import('java.io.FileOutputStream')
ByteArrayOutputStream = Rjb::import('java.io.ByteArrayOutputStream')
ByteArrayInputStream  = Rjb::import('java.io.ByteArrayInputStream')
PdfWriter             = Rjb::import('com.lowagie.text.pdf.PdfWriter')
PdfReader             = Rjb::import('com.lowagie.text.pdf.PdfReader')
PdfCopy               = Rjb::import('com.lowagie.text.pdf.PdfCopy')
PdfImportedPage       = Rjb::import('com.lowagie.text.pdf.PdfImportedPage')
Document              = Rjb::import('com.lowagie.text.Document')
Paragraph             = Rjb::import('com.lowagie.text.Paragraph')
AcroFields            = Rjb::import('com.lowagie.text.pdf.AcroFields')
PdfStamper            = Rjb::import('com.lowagie.text.pdf.PdfStamper')
HashMap               = Rjb::import('java.util.HashMap')
Iterator              = Rjb::import('java.util.Iterator')

require 'pdf_filler/util_methods'
require 'pdf_filler/page'
require 'pdf_filler/book'
require 'pdf_filler/pdf_db_mapper'


module Kernel

  # A shortcut kernel method for creating a new PDF Page without having to specify the full path to the page.
  # Therefore, 
  # * PDFPage(template)
  # and
  # * GBDev::PDF::Page.new(template)
  # are the same thing.
  def PDFPage(template)
    GBDev::PDF::Page.new(template)
  end
  
  # A shortcut kernel method for creating a new PDF Book without having to specify the full path to the book.
  # Therefore, 
  # * PDFBook()
  # and
  # * GBDev::PDF::Book.new
  # are the same thing.  
  def PDFBook()
    GBDev::PDF::Book.new
  end  
  
end
