module Prawn
  module Html
    module PdfNodeGenerator
      module Helper
        def get_positions(render_options)
          return render_options[:xpos], render_options[:ypos]  
        end

        def set_positions(render_options, xpos, ypos)
          render_options[:xpos] = xpos
          render_options[:ypos] = ypos  
          render_options
        end
      end
    end
  end
end