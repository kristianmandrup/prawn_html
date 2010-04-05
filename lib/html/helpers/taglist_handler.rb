module Prawn
  module Html
    module TagListHandler

      def tag_modifer(options, key, modifier)            
        tag_list = options[modifier][key] if options[modifier]
        [tag_list || []].flatten
      end        

      def tag_modifers(options, key)      
        [tag_modifer(options, key, :include), tag_modifer(options, key, :exclude)]
      end      
    end
  end
end
