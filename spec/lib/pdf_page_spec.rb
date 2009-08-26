require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe 'Page' do
  
  it 'should create the page and write to the output directory' do    
    page = GBDev::PDF::Page.new(File.expand_path(File.dirname(__FILE__) + '/../templates/certificate_template.pdf'))
    page.set_text_field(:full_name, 'Wes Hays')
    page.save_to(File.expand_path(File.dirname(__FILE__) + '/../output/wes_hays.pdf'))
    File.exist?(File.dirname(__FILE__) + '/../output/wes_hays.pdf').should be_true
  end
  
  it 'should create the page and write to the output directory with Kernel method' do    
    page = PDFPage(File.expand_path(File.dirname(__FILE__) + '/../templates/certificate_template.pdf'))
    page.set_text_field(:full_name, 'Wes Hays')
    page.save_to(File.expand_path(File.dirname(__FILE__) + '/../output/wes_hays.pdf'))
    File.exist?(File.dirname(__FILE__) + '/../output/wes_hays.pdf').should be_true
  end
  
  it 'should find all three fields: text field, checkbox and radio buttons' do
    page = PDFPage(File.expand_path(File.dirname(__FILE__) + '/../templates/form_template.pdf'))
    fields = page.get_pdf_fields
    
    fields.has_key?(:full_name).should be_true
    fields[:full_name].should == GBDev::PDF::Page::TEXT_FIELD
    
    fields.has_key?(:home_owner).should be_true
    fields[:home_owner].should == GBDev::PDF::Page::RADIO_BUTTON
    
    fields.has_key?(:newsletter).should be_true
    fields[:newsletter].should == GBDev::PDF::Page::CHECK_BOX
    
    fields.has_key?(:car_types).should be_true
    fields[:car_types].should == GBDev::PDF::Page::LIST
    
    fields.has_key?(:sibling_count).should be_true
    fields[:sibling_count].should == GBDev::PDF::Page::COMBO_BOX   
    
    # fields.has_key?(:owner_signature).should be_true
    # fields[:owner_signature].should == GBDev::PDF::Page::SIGNATURE
    #
    # fields.has_key?(:submit_button).should be_true
    # fields[:submit_button].should == GBDev::PDF::Page::PUSH_BUTTON
    #
    # fields.has_key?(:photo).should be_true
    # fields[:photo].should == GBDev::PDF::Page::IMAGE     
  end
   
  it 'should find all the valid states for the check box' do
    page = PDFPage(File.expand_path(File.dirname(__FILE__) + '/../templates/form_template.pdf'))
    states = page.get_field_states(:newsletter) # Checkbox
    states.should == ['Yes','Off']  
  end
  
  it 'should find all the valid states for the radio button' do
    page = PDFPage(File.expand_path(File.dirname(__FILE__) + '/../templates/form_template.pdf'))
    states = page.get_field_states(:home_owner) # radio button
    states.should == ['Yes','No','Off']  # Off will not be used but AcroFields returns it anyway.
  end  
  
  it 'should find all the valid states for the list' do
    page = PDFPage(File.expand_path(File.dirname(__FILE__) + '/../templates/form_template.pdf'))
    states = page.get_field_states(:car_types) # List
    states.sort.should == ['Chevy', 'Ford', 'Honda', 'Jeep', 'Toyota'].sort
  end  
  
  it 'should find all the valid states for the combo box' do
    page = PDFPage(File.expand_path(File.dirname(__FILE__) + '/../templates/form_template.pdf'))
    states = page.get_field_states(:sibling_count) # List
    states.sort.should == ['Zero','One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten'].sort
  end  
  
  it 'should fill all fields' do
    page = PDFPage(File.expand_path(File.dirname(__FILE__) + '/../templates/form_template.pdf'))
    page.set_text_field(:full_name, 'Anna Hays')        
    page.set_checkbox(:home_owner, 'Yes') 
    page.set_checkbox(:newsletter, 'Yes')
    page.set_checkbox(:car_types, 'Jeep')
    page.set_checkbox(:sibling_count, 'One')
    page.save_to(File.expand_path(File.dirname(__FILE__) + '/../output/form_test.pdf'))
    File.exist?(File.dirname(__FILE__) + '/../output/form_test.pdf').should be_true    
  end
  
  it 'should return the buffer without writing to disk' do
    page = PDFPage(File.expand_path(File.dirname(__FILE__) + '/../templates/certificate_template.pdf'))
    page.set_text_field(:full_name, 'Wes Hays')
    pdf_data = page.to_buffer
    pdf_data.should_not be_blank
  end
end