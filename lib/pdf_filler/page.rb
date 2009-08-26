module GBDev
  
  module PDF
  
    # A page that represents a PDF page.
    class Page
      
      CHECK_BOX    = 'Check Box'
      COMBO_BOX    = 'Combo Box'
      LIST         = 'List'
      PUSH_BUTTON  = 'Push Button'
      RADIO_BUTTON = 'Radio Button'
      SIGNATURE    = 'Signature'
      TEXT_FIELD   = 'Text Field'
      NONE         = 'None'
      UNKNOWN      = '?'
      
      # String template : A path to the template file
      def initialize(template)
        @template = template
        
        @pdf_fields = {}
        
        @check_boxes = {}
        @images = {}
        @radio_buttons = {}
        @signature_fields = {}
        @text_fields = {}
        
        @pdf_reader = nil
      end
      
      # Returns a hash where the keys are the field names in the template PDF and the values are the field types.
      def get_pdf_fields
        return @pdf_fields unless @pdf_fields.empty?
        
        reader = PdfReader.new(@template)
        form = reader.getAcroFields()
        fields = form.getFields()
        i = fields.keySet().iterator()
        
        while(i.hasNext())
          key = i.next()

          case(form.getFieldType(key))
            when AcroFields.FIELD_TYPE_CHECKBOX
              @pdf_fields[key.to_string().to_sym] = GBDev::PDF::Page::CHECK_BOX
            when AcroFields.FIELD_TYPE_COMBO
              @pdf_fields[key.to_string().to_sym] = GBDev::PDF::Page::COMBO_BOX
            when AcroFields.FIELD_TYPE_LIST 
              @pdf_fields[key.to_string().to_sym] = GBDev::PDF::Page::LIST
            when AcroFields.FIELD_TYPE_NONE 
              @pdf_fields[key.to_string().to_sym] = GBDev::PDF::Page::NONE
            when AcroFields.FIELD_TYPE_PUSHBUTTON
              @pdf_fields[key.to_string().to_sym] = GBDev::PDF::Page::PUSH_BUTTON
            when AcroFields.FIELD_TYPE_RADIOBUTTON
              @pdf_fields[key.to_string().to_sym] = GBDev::PDF::Page::RADIO_BUTTON
            when AcroFields.FIELD_TYPE_SIGNATURE
              @pdf_fields[key.to_string().to_sym] = GBDev::PDF::Page::SIGNATURE
            when AcroFields.FIELD_TYPE_TEXT
              @pdf_fields[key.to_string().to_sym] = GBDev::PDF::Page::TEXT_FIELD
            else 
              @pdf_fields[key.to_string().to_sym] = GBDev::PDF::Page::UNKNOWN
          end
        end
        
        return @pdf_fields
      end
      
      # Returns an array of field states.  For example if the field type is a list an array
      # with all possible choices in the list will be returned.
      #
      # * field_name - The field name to get all the possible states for.
      def get_field_states(field_name)
        reader = PdfReader.new(@template)
        form = reader.getAcroFields()
        form.getAppearanceStates(field_name.to_s);
      end
      
      
      # Sets a know checkbox in the PDF template.
      #
      # * key - A known checkbox in the PDF.
      # * value - The checkbox to update.
      def set_checkbox(key, value)
        @check_boxes[key] = value
      end
      
      # Alias for the set_checkbox method
      alias :checkbox :set_checkbox      
      
      # NOT WORING YET
      # Sets a known image area in the PDF template.
      #
      # * key - A known image in the PDF.
      # * value - The image to apply to the know image area.
      def set_image(key, value)
        raise 'Image not working yet'
        @images[key] = value
      end     
      
      # Alias for the set_image method
      alias :image :set_image      
      
      
      # Sets a known radio button in the PDF template.
      #
      # * key - A known radio button group in the PDF.
      # * value - The radio button group to update.
      def set_radio_button(key, value)
        @radio_buttons[key] = value
      end
      
      # Alias for the set_checkbox method
      alias :radio_button :set_radio_button

      
      # NOT WORKING YET
      # Sets a known signature field in the PDF template.
      #
      # * key - A known signature field in the PDF.
      # * value - The value to apply to the know field.
      def set_signature_field(key, value)
        raise 'Signature field not working yet'
        @signature_fields[key] = value
      end
      
      # Alias for set_signature_field method
      alias :signature_field :set_signature_field
            
      
      # Sets a known text field in the PDF template.
      #
      # * key - A known text field in the PDF.
      # * value - The value to apply to the know field.
      def set_text_field(key, value)
        @text_fields[key] = value
      end
      
      # Alias for set_text method
      alias :text_field :set_text_field
      
      # Maps PDF fields to an ActiveRecord object. The ActiveRecord object must use the
      # acts_as_pdf_db_mapper module.
      #
      # * object - An ActiveRecord object that uses the acts_as_pdf_db_mapper module.
      def map_to_object(object)
        if object.methods.include?('mapped_fields')
          fields = self.get_pdf_fields
          object.mapped_fields.each do |mapped_field|
            
            if mapped_field.class.to_s == 'Hash'
              key_value_pair = mapped_field.first.to_a.flatten
              key = key_value_pair[0]
              value = key_value_pair[1]
            else
              key = mapped_field
              value = mapped_field
            end

            case(fields[key])
              when GBDev::PDF::Page::CHECK_BOX
                self.set_checkbox(key, object.send(value))
              when GBDev::PDF::Page::COMBO_BOX
                #self.set_combobox(key, object.send(value))
              when GBDev::PDF::Page::LIST
                #self.set_list(key, object.send(value))
              when GBDev::PDF::Page::NONE
                #self.set_none(key, object.send(value))
              when GBDev::PDF::Page::PUSH_BUTTON
                #self.set_push_button(key, object.send(value))
              when GBDev::PDF::Page::RADIO_BUTTON
                self.set_radio_button(key, object.send(value))
              when GBDev::PDF::Page::SIGNATURE
                self.set_signature_field(key, object.send(value))
              when GBDev::PDF::Page::TEXT_FIELD
                self.set_text_field(key, object.send(value))
            end            
            
          end
        end
      end
      
      
      # Renders the template with the given data and saves to the given filename path.
      #
      # * filename - A path to the file to be created.  
      def save_to(filename)                      
        field_cache = HashMap.new
        reader = PdfReader.new(@template)
        stamper = PdfStamper.new( reader, FileOutputStream.new(filename) )
        form = stamper.getAcroFields()
        form.setFieldCache(field_cache)
        
        all_fields = {}
        all_fields.merge!(@check_boxes)
        all_fields.merge!(@radio_buttons)
        all_fields.merge!(@signature_fields)
        all_fields.merge!(@text_fields)

        all_fields.each do |field, value|
          form.setField(field.to_s, value.to_s)
        end        

        # TODO: do something with @images 

        stamper.setFormFlattening(true)
        stamper.close                    
      end
      
      
      # Renders the template with the given data and returns that buffer.    
      def to_buffer
        field_cache = HashMap.new
        reader = PdfReader.new(@template)
        baos = ByteArrayOutputStream.new 
        stamper = PdfStamper.new( reader, baos )
        form = stamper.getAcroFields()
        form.setFieldCache(field_cache)
        
        all_fields = {}
        all_fields.merge!(@check_boxes)
        all_fields.merge!(@radio_buttons)
        all_fields.merge!(@signature_fields)
        all_fields.merge!(@text_fields)

        all_fields.each do |field, value|
          form.setField(field.to_s, value.to_s)
        end        

        # TODO: do something with @images 

        stamper.setFormFlattening(true)
        stamper.close
        
        return baos.toByteArray()
      end
  
      
      include GBDev::Utils::PrivateMethods
      
    end # End Page

  end # End PDF

end # End GBDev
