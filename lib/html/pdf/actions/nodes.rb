module Prawn
  module Html
    module PdfActionHandler
      module Nodes 
        def item(key)
          return nil if list[key].size == 0
          item = list[key].shift
          set_positions(render_options, xpos, ypos)          
          item
        end
                       
        def do_table
          table = item(:tables)
          xpos, ypos = Table.pdf(pdf, item, table, render_options)          
        end

        def do_image             
          handle_new_page # why here!?
          table = item(:images)
          xpos, ypos = Image.pdf(pdf, item, img,  render_options)
        end       
        
        
      end
    end
  end
end
