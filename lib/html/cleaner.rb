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


html = %q{
  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
     "http://www.w3.org/TR/html4/strict.dtd">
  <html lang="en">
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  	<title>untitled</title>
  	<meta name="generator" content="TextMate http://macromates.com/">
  	<meta name="author" content="Kristian Mandrup">
  	<!-- Date: 2010-04-04 -->
  </head>
  <body>
    <h1>Hello World</h1>
  </body>
  </html>
}

cleaner = Prawn::Html::Cleaner.new(:include => {:strip_tags => 'h1' }, :exclude => {:erase_tags => 'table' })
puts cleaner.custom_strip_tags.inspect
puts cleaner.custom_erase_tags.inspect  

clean_html = cleaner.clean(html)
puts clean_html

cleaner = Prawn::Html::Fixer.new(:include => {:block_tags => 'h1' }, :exclude => {:block_tags => ['h3', 'div'] })

fixed_html = fixer.fix(html)
puts fixed_html


