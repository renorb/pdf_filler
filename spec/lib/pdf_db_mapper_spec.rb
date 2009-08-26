require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe 'PDF_DB_Mapper' do
  
  before(:each) do
    Address.create_corpus!
  end
  
  after(:each) do
    Address.destroy_all
  end
  
  it 'should allow all database columns to be mapped if no :only or :except is specified' do
    address = Address.first
    fields_array = address.mapped_fields.collect{|f| f.to_s}.sort
    fields_array.should == ['id', 'address1', 'address2', 'city', 'state', 'postal_code'].sort
  end
  
  it 'should only map the fields specified by :only' do
    address = ClientAddress.first
    fields_array = address.mapped_fields.collect{|f| f.to_s}.sort
    fields_array.should == ['city', 'state'].sort
  end
  
  it 'should map all the fields except the fields specified by :except' do
    address = ContactAddress.first
    fields_array = address.mapped_fields.collect{|f| f.to_s}.sort
    fields_array.should == ['address2', 'city', 'state'].sort    
  end
  
  it 'should include the additional mappings specified by :include' do
    address = UserAddress.first
    fields_array = address.mapped_fields.collect{|f| f.class.to_s == 'Hash' ? f.first.to_a.flatten.join('::') : f.to_s}.sort
    fields_array.should == ['id', 'address1', 'address2', 'city', 'state', 'postal_code','full_address::address'].sort    
  end
  
  it 'should only include the mappings specified by :only_include' do
    address = FamilyAddress.first
    fields_array = address.mapped_fields.collect{|f| f.first.to_a.flatten.join('::')}.sort
    fields_array.should == ['full_address::address'].sort    
  end  
  
  it 'should map the specified fields for a single record to a single page' do
    page = PDFPage(File.expand_path(File.dirname(__FILE__) + '/../templates/address_template.pdf'))
    address = Address.first
    page.map_to_object(address)
    page.save_to(File.expand_path(File.dirname(__FILE__) + '/../output/db_address.pdf'))
    File.exist?(File.dirname(__FILE__) + '/../output/db_address.pdf').should be_true
  end    
  
end