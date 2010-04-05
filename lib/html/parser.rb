require 'html/cleaner'
require 'html/fixer'

module Prawn
  module Html
    class Parser     
      attr_accessor :options, :cleaner, :fixer
      
      def initialize(options = {})
        @cleaner = Cleaner.new || options[:cleaner]
        @fixer = Fixer.new || options[:fixer]        
      end  

      # returns a "pdf model"
      def parse(html, options = {})
        # clean html
        clean_html = cleaner.clean(html, options)

        # fix html
        pdf_model = fixer.fix(clean_html, options)
      end

    end
  end
end