module Prawn
  module Html    
    class Fixer 
      module Paragraph
        def break_marker 
          'BREAK'
        end
                
        def initialize(options = {})
        end

        def fix_paragraphs(html)          
          html.replace_start_tags_marker!('p', break_marker)
          html.strip_tags!('p')
        end
      end
    end
  end
end

