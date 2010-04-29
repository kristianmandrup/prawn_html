require 'html/helpers/cleaner_ops'
require 'html/helpers/taglist_handler'

module Prawn
  module Html    
    class Cleaner 
      include TagListHandler  
      attr_accessor :custom_strip_tags, :custom_erase_tags
      
      def tags_to_strip 
        ['span', 'div', 'body', 'html', 'form', 'head'] 
      end

      def tags_to_erase 
        ['object', 'script', 'applet', 'select', 'button', 'input', 'textarea', 'style', 'iframe', 'meta', 'link', 'hr']      
      end  
      
      def initialize(options = {})
        config_strip_tags(options)
        config_erase_tags(options)
      end  

      def tags_to_strip 
        ['span', 'div', 'body', 'html', 'form', 'head'] 
      end

      def config_strip_tags(options)                  
        included, excluded = tag_modifers(options, :strip_tags)
        @custom_strip_tags = tags_to_strip + included - excluded
      end

      def config_erase_tags(options)                  
        included, excluded = tag_modifers(options, :erase_tags)
        @custom_erase_tags = tags_to_erase + included - excluded
      end

      # cleans up html code before conversion step
      def clean(html, options = {})   
        html.extend(Prawn::Html::CleanerOperations)
        erase_tags(html, options)
        strip_tags(html, options) 
        html.erase_comments! 
        html.erase_doctype!
        html.remove_whitespace!        
        html       
      end
      
      def erase_tags(html, options = {})
        custom_erase_tags.each do |tag|
          html.erase_tags!(tag)
        end 
      end

      def strip_tags(html, options = {})
        custom_strip_tags.each do |tag|
          html.strip_tags!(tag)
        end
      end        

    end
  end
end    



