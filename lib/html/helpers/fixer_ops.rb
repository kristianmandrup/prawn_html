module Prawn
  module Html
    module FixerOperations 
      def add_after_end_tag!(tag, replace_str)
        self.gsub!(/<\/#{tag}>/i, "\1#{replace_str}")    
      end
      
      # encure matches newlines (any white-space!) between tag markers 
      def replace_tags_marker!(tag, marker)
        sep = ":#:"
        marker = "#{sep}#{marker}#{sep}"
        self.gsub!(/<#{tag}[^>]*>(.|\n)*?<\/#{tag}>/i, marker)
        self.gsub!(/<#{tag}(.|\n)*?\/>/i, marker)
      end  

      # encure matches newlines (any white-space!) between tag markers 
      def replace_start_tags_marker!(tag, marker)
        sep = ":#:"
        marker = "#{sep}#{marker}#{sep}"
        self.gsub!(/<#{tag}[^>]*>/i, marker)
        self.gsub!(/<#{tag}(.|\n)*?\/>/i, marker)
      end   
      
    end
  end
end
                           
