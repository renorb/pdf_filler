module GBDev
  
  module PDF
  
    # A book that represents collection of PDF page.
    class Book
      
      def initialize()
        @pages = []
      end
      
      # Add a page to the book
      #
      # * new_page - The page object of type GBDev::PDF::Page
      def add_page(new_page)
        @pages << new_page
      end
      
      # Renders the PDF Book and saves it to the specified file.
      #
      # * filename - A path to the file to be created.      
      def save_to(filename)
        dir = File.dirname(filename)             
        temp_dir = [dir, "collection_temp_#{build_random_string}"].join('/')
        Dir.mkdir(temp_dir)
        @pages.each_with_index do |page, indx| 
          page.save_to([temp_dir, "#{indx}_#{build_random_file_name}"].join('/'))
        end
        temp_files = Dir[[temp_dir,'*'].join('/')].sort                 
            
        document = Document.new
        copier = PdfCopy.new(document, FileOutputStream.new(filename))
      
        document.open        
        temp_files.each do |read_target|
          reader = PdfReader.new(read_target)
          n_pages = reader.getNumberOfPages
          n_pages.times do |i|
            copier.addPage( copier.getImportedPage(reader, i+1)) if copier
          end
        end        
        document.close
              
        FileUtils.rm_rf(temp_dir, {:secure => true})        
      end      
      
      # Renders the template with the given data and returns that buffer.    
      def to_buffer
        dir = defined?(RAILS_ROOT) ? [RAILS_ROOT, 'tmp'].join('/') : File.expand_path(File.dirname(__FILE__) + '/../../spec/output')         
        temp_dir = [dir, "collection_temp_#{build_random_string}"].join('/')
        Dir.mkdir(temp_dir)
        @pages.each_with_index do |page, indx| 
          page.save_to([temp_dir, "#{indx}_#{build_random_file_name}"].join('/'))
        end
        temp_files = Dir[[temp_dir,'*'].join('/')].sort                 
            
        document = Document.new        
        baos = ByteArrayOutputStream.new
        copier = PdfCopy.new(document, baos)
      
        document.open        
        
        # This did not work but try working on it again later.
        # @pages.each do |page|
        #   bais = ByteArrayInputStream.new_with_sig(page.to_buffer)
        #   reader = PdfReader.new(bais)
        #   reader = page.get_pdf_reader
        #   n_pages = reader.getNumberOfPages
        #   n_pages.times do |i|
        #     copier.addPage( copier.getImportedPage(reader, i+1)) if copier
        #   end
        # end        
        
        temp_files.each do |read_target|
          reader = PdfReader.new(read_target)
          n_pages = reader.getNumberOfPages
          n_pages.times do |i|
            copier.addPage( copier.getImportedPage(reader, i+1)) if copier
          end
        end        
        document.close
              
        #FileUtils.rm_rf(temp_dir, {:secure => true})       
              
        return baos.toByteArray()
      end      
      
      include GBDev::Utils::PrivateMethods
      
    end # End Filler

  end # End PDF

end # End GBDev
