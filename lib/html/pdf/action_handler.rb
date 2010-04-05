# TODO: dynamically include all
# Use require-me
require 'html/pdf/actions/position'
require 'html/pdf/actions/nodes'

module Prawn
  module Html
    module PdfActionHandler
      include Prawn::Html::PdfGeneratorNode::Helper
      include Position
      include Nodes      
      
      def do_default
        breaks = item.scan(/<br>/i).length + item.scan(/<br\/>/i).length
        ypos = start_page_ypos if !ypos 
        ypos += (breaks * break_height)
        puts item
        pdf.text(item) if !item.blank?
      end

      
    end
  end
end