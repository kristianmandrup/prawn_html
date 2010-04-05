module Prawn
  module Html    
    class Fixer 
      include TagListHandler
       
      attr_accessor :custom_block_tags
      
      def block_tags 
        tags || = ['div', 'title'] + header_tags
      end      

      def header_tags 
        tags || = (1..9).collect{|n| "h#{n}"}
      end

      def initialize(options = {})
        config_block_tags(options)
      end  

      def config_block_tags(options)                  
        included, excluded = tag_modifers(options, :block_tags)
        @custom_block_tags = block_tags + included - excluded
      end
      
      def fix(html, *tags) 
        html.extend(FixerOperations)
        fix_block_tags(html, block_tags)  
        
        # TODO: make more flexible by auto including and executing fixers! 
        
        # use other fixers
        table_fixer = Table.new.fix(html)
        image_fixer = Image.new.fix(html)        
        
        {:html_list => html.split(/:#:/), :tables => table_fixer.tables, :images => image_fixer.images}        
      end
      
      def fix_block_tags(tags)
        tags.each{|tag| html.add_after_end_tag!(tag, '<br/>') }
      end
      
    end
  end   
end
