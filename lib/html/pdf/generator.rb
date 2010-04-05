require 'html/parser'

module Prawn
  module Html
    class PdfGenerator      
      attr_accessor :options

      def default_pdf_options 
        # calculations
        line_height = 12       
        break_height = line_height + (line_height / 4)        

        position_options = {:position => {:ypos => 30, :xpos => 0, :new_page_ypos => 30}
        scale_options = {:scale => {:page_height => 600, :line_height => line_height, :break_height => break_height}
        table_options = {:table => {:line_height => 16, :font_size => 12, :cell_width => 120}}

        pdf_options = position_options + scale_options + table_options 
        {:pdf_gen => pdf_options}
      end    

      def initialize(options = {})
        options = default_pdf_options.merge(options)
        parser = Prawn::Html::Parser.new(options[:parse])
        action_handler = Prawn::Html::PdfActionHandler.new(options[:action])
      end
  
      def create_pdf(pdf, html, options = {})
        self.options.merge!(options)

        # parse
        pdf_model = parser.parse(html, options)

        # generate pdf      
        pdf_model[:instructions].each do |item|
          case item 
            when 'BREAK'
              action_handler.do_break
            when 'TABLE'
              action_handler.do_table
            when 'IMG'                  
              action_handler.do_image
            when 'NEW_PAGE'
              action_handler.do_new_page      
            else
              action_handler.do_default 
            end
          end
        end        
      end
            
    end