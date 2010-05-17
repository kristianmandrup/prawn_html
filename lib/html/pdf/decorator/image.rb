module Prawn
  module Html
    module PdfNodeGenerator            
      class Image  
        include Helper
                  
        attr_accessor :options

        def default_img_options
          {}
        end

        def initialize(options = {})
          @options = default_img_options.merge(options)
        end
        
        def pdf(pdf, item, img,  render_options)
          xpos, ypos = Prawn::Assist::get_positions(render_options)      
          if img[:src]
            configure

            ypos = render_options[:ypos]

            pdf.image open(img[:src]), options 
            break_height = (render_options[:break_height] || 12)

            pdf.move_down break_height
            total_height = (img[:height] + break_height)
            ypos += total_height

            image_title
            image_break

            set_positions(render_options, xpos, ypos)                                  
          end
          return xpos, ypos
        end  

        def image_title
          if img[:title]
            pdf.text img[:title]
            ypos += break_height             
          end
        end

        def image_break
          if img[:nobreak]                    
            xpos += (img[:width] + 20) 
            ypos -= total_height
            pdf.move_up total_height
            if img[:title]
              ypos -= break_height
            end
          else
            xpos = 0         
          end 
        end

        def configure
          options = {:position => (xpos if xpos > 0) || :left, :vposition => render_options[:ypos]}
          options[:width] = img[:width] if img[:width] > 0
          options[:height] = img[:height] if img[:height] > 0
        end
      end
    end
  end
end