require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe 'Book' do
  
  it 'should create the book of pages and write to the output directory' do
    book = RenoRB::PDF::Book.new
    
    template_file = File.expand_path(File.dirname(__FILE__) + '/../templates/certificate_template.pdf')
    pdf_book = File.expand_path(File.dirname(__FILE__) + '/../output/certs.pdf')

    page1 = RenoRB::PDF::Page.new(template_file)
    page1.set_text_field(:full_name, 'Wes Hays')

    page2 = RenoRB::PDF::Page.new(template_file)
    page2.set_text_field(:full_name, 'Darren Johnson')

    page3 = RenoRB::PDF::Page.new(template_file)
    page3.set_text_field(:full_name, 'John Dell')
    
    book.add_page(page1)
    book.add_page(page2)
    book.add_page(page3)
    
    book.save_to(pdf_book)
    
    File.exist?(pdf_book).should be_true
  end  
  
  it 'should create the book of pages and write to the output directory with Kernel method' do
    book = PDFBook()
    
    template_file = File.expand_path(File.dirname(__FILE__) + '/../templates/certificate_template.pdf')
    pdf_book = File.expand_path(File.dirname(__FILE__) + '/../output/certs.pdf')

    page1 = RenoRB::PDF::Page.new(template_file)
    page1.set_text_field(:full_name, 'Wes Hays')

    page2 = RenoRB::PDF::Page.new(template_file)
    page2.set_text_field(:full_name, 'Darren Johnson')

    page3 = RenoRB::PDF::Page.new(template_file)
    page3.set_text_field(:full_name, 'John Dell')
    
    book.add_page(page1)
    book.add_page(page2)
    book.add_page(page3)
    
    book.save_to(pdf_book)
    
    File.exist?(pdf_book).should be_true
  end  
  
  it 'should return the buffer without writing to disk' do
    book = PDFBook()
    
    template_file = File.expand_path(File.dirname(__FILE__) + '/../templates/certificate_template.pdf')

    page1 = RenoRB::PDF::Page.new(template_file)
    page1.set_text_field(:full_name, 'Wes Hays')

    page2 = RenoRB::PDF::Page.new(template_file)
    page2.set_text_field(:full_name, 'Darren Johnson')

    page3 = RenoRB::PDF::Page.new(template_file)
    page3.set_text_field(:full_name, 'John Dell')
    
    book.add_page(page1)
    book.add_page(page2)
    book.add_page(page3)
    
    book.to_buffer.should_not be_blank
  end  
  
end