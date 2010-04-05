module Prawn
  module Html
    module PdfActionHandler
      module Position
        def do_break
          pdf.move_down break_height
          ypos += break_height 
        end

        def do_new_page
          if ypos > options[:position][:page_height]                  
             pdf.start_new_page 
             ypos = start_page_ypos
          end
        end          
      end
    end
  end
end
