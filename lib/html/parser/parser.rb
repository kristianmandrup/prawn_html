module Prawn
  module Html
    class Parser     
      attr_accessor :options
      
      def initialize(options = {})
      end  
      
      def parse(original_html, options = {})
        # clean html
        clean_html = Cleaner.new.clean(original_html)
        # parse html
        clean_parse(clean_html, options)
      end

    protected
      def clean_parse(html, options = {})
      end
    end
  end
end