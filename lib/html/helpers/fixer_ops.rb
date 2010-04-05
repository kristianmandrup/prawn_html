module Prawn
  module Html
    module FixerOperations 
      def add_after_end_tag!(tag, replace_str)
        self.gsub!(/<\/#{tag}>/i, "\1#{replace_str}")    
      end
    end
  end
end
                           
