module Prawn
  module Html    
    class Fixer 
      class Image
        attr_accessor :images
        
        def image_marker 
          'IMAGE'
        end
                
        def initialize(options = {})
          @images = []
        end

        def fix(html, doc)          
          
          doc.css('img').each do |img|
            images << get_img_hash(img)
          end

          html.replace_tags_marker!('img', image_marker)
          self
        end

      protected
        def get_img_hash(img)
          img_hash = {:src => img['src'].to_s, :width => img['width'].to_i || 200, :height => img['height'].to_i || 200, :title => img['title'] || img['alt'] }
          img_hash[:nobreak] = (img['nobreak'] && (img['nobreak'] != 'false'))        
          img_hash
        end
        
      end
    end
  end
end



