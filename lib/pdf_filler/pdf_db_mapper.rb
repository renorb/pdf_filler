require 'active_record'

module RenoRB #:nodoc:
  module PDF #:nodoc:
    module Acts #:nodoc:
      module PDFDBMapper # :nodoc:

        def self.included(mod)
          mod.extend(ClassMethods)
        end

        module ClassMethods  
         
          # Automatically maps database fields to fields found in the template PDF with the same name.
          # Database fields not found in the template PDF are ignored.  If no options are specified then
          # by default all table fields will attempt to be mapped.
          #
          # Configuration options are: 
          #
          # * :only - Only map the database fields specified. i.e :only => [:first_name, :last_name]
          # * :except - Map all the table fields except those specified.  i.e. :except => [:middle_name]
          # * :include - Allows for a method to map to a field in the PDF. If you have a method called full_name 
          #   that combines the first name and last name, you could map that method to a PDF text field called full_name.
          #   :include => [:full_name].  
          #   You could all specify a model attribute/method to map to a different PDF field. 
          #   i.e. :include => [{:full_name => :dog_name}]
          #   :include will still work with :only and :except.
          # * :only_include - Will ignore :only and :except and only includes the manual mappings specified.
          #   i.e. :only_include => [:full_name, {:animal_name => :dog_name}]
          def acts_as_pdf_db_mapper(*fields) 
 
            # Make sure that the table to be mapped actually exists
            if self.table_exists?

              # Get a collection of fields to be searched on.
              if fields.first.class.to_s == 'Hash'
                
                if fields.first.has_key?(:only_include)
                  fields_to_map = fields.first[:only_include]
                else
                  if fields.first.has_key?(:only)
                    # only map on these fields.
                    fields_to_map = fields.first[:only]
                  elsif fields.first.has_key?(:except)
                    # Get all the fields and remove any that are in the -except- list.
                    fields_to_map = self.column_names.collect { |column| fields.first[:except].include?(column.to_sym) ? nil : column.to_sym }.compact
                  else
                    fields_to_map = self.column_names.collect { |column| column.to_sym }
                  end
                
                  if fields.first.has_key?(:include)
                    fields_to_map += fields.first[:include]
                  end
                end
              else 
                fields_to_map = self.column_names.collect { |column| column.to_sym }
              end            

              # Set the appropriate class attributes. 
              self.cattr_accessor :mapped_fields
              self.mapped_fields = fields_to_map    
              
            end # End table exists check
            
          end # acts_as_pdf_db_mapper
  
        end # ClassMethods
     
      end # PDFDBMapper
    end # Acts
  end # PDF
end # RenoRB

ActiveRecord::Base.send(:include, RenoRB::PDF::Acts::PDFDBMapper)