module Prawn
  module Html    
    class Fixer 
      module List
        def initialize(options = {})
        end                
        
        def fix_lists(html)
          doc = Nokogiri::HTML.parse(html)
          fix_ordered_list(doc, html)
          fix_unordered_list(doc, html)
        end
        
        def fix_unordered_list(doc, html)
          doc.css(unordered_list_tag).each do |ul|
            res = "<br/>"
            ul.css('li').each_with_index do |li, index|
              res << "- #{li.inner_html} <br/>"
            end
            html.replace_tag!(unordered_list_tag, res)
          end
        end
        
        def fix_ordered_list(doc, html)          
          doc.css(ordered_list_tag).each do |ul|
            res = "<br/>"
            ul.css('li').each_with_index do |li, index|
              res << "#{index+1}. #{li.inner_html} <br/>"
            end
            html.replace_tag!(ordered_list_tag, res)
          end
        end        
        
      protected  
        def ordered_list_tag
          'ol'        
        end

        def unordered_list_tag
          'ul'        
        end

      end
    end
  end
end