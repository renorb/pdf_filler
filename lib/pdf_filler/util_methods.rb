module RenoRB #:nodoc: all

  module Utils
    
    module PrivateMethods
  
      def build_random_string # :nodoc:
        letters_array = [('a'..'z'),('A'..'Z')].collect{|i| i.to_a}.flatten
        (1..10).collect{ letters_array[ rand(letters_array.length) ] }.join 
      end
      
      def build_random_file_name # :nodoc:
        build_random_string << '.pdf'
      end              
  
    end
    
    
    # Include these controller methods to prompt the user to download the PDF.
    #
    # * include RenoRB::Utils::ControllerMethods
    module ControllerMethods
      
      # Used to display the PDF without saving it to disk.
      # 
      # * buffer - A Page buffer or Book buffer.
      # * filename - The filename to apply to the buffer when prompted to download.
      def display_pdf(buffer, filename)
        send_data(buffer, {:type        => 'application/pdf',
                           :disposition => 'attachment',
                           :filename    => filename} )
      end
      

      # From here: http://railspdfplugin.rubyforge.org/wiki/wiki.pl
      # Suggested code so errors will always show in browser
      def rescue_action_in_public(exception) # :nodoc:
        headers.delete("Content-Disposition")
        super
      end

      def rescue_action_locally(exception) # :nodoc:
        headers.delete("Content-Disposition")
        super
      end
      
    end
    
  end
end