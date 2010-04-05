module Prawn
  module Html
    module CleanerOperations 
      # <TAG\b[^>]*>(.*?)</TAG>      
      # <([A-Z][A-Z0-9]*)\b[^>]*>(.*?)</\1>
      # http://www.regular-expressions.info/examples.html
      
      def strip_tags!(tag)
        self.gsub!(/<\/?#{tag}\b[^>]*>/i, "")      
      end

      # encure matches newlines (any white-space!) between tag markers 
      def replace_tags!(tag, replace_str)
        self.gsub!(/<#{tag}\b[^>]*>(.*?)<\/?#{tag}>/i, replace_str)
        self.gsub!(/<#{tag}\b[^>]*\/?>/i, replace_str)
      end

      def erase_tags!(tag)
        replace_tags!(tag, '')
      end

      def erase_comments!
        self.gsub!(/<!--(.|\n)*?-->/i, '')
      end
      
      def erase_doctype!
        self.gsub!(/<!DOCTYPE(.|\n)*?>/i, '')
      end

      def remove_newlines!
        self.gsub!(/\n/, '')    
      end  

      def remove_whitespace!
        self.gsub!(/\s+/, ' ')    
      end  

    end
  end
end