# :headers: An array of table headers, either strings or Cells. [Empty]
# :align_headers: Alignment of header text. Specify for entire header (:left) or by column ({ 0 => :right, 1 => :left}). If omitted, the header alignment is the same as the column alignment.
# :header_text_color: Sets the text color of the headers
# :header_color:  Manually sets the header color
# :font_size: The font size for the text cells . [12]
# :horizontal_padding:  The horizontal cell padding in PDF points [5]
# :vertical_padding:  The vertical cell padding in PDF points [5]
# :padding: Horizontal and vertical cell padding (overrides both)
# :border_width:  With of border lines in PDF points [1]
# :border_style:  If set to :grid, fills in all borders. If set to :underline_header, underline header only. Otherwise, borders are drawn on columns only, not rows
# :border_color:  Sets the color of the borders.
# :position:  One of :left, :center or n, where n is an x-offset from the left edge of the current bounding box
# 
# :width: A set width for the table, defaults to the sum of all column widths :column_widths: A hash of indices and widths in PDF points. E.g. { 0 => 50, 1 => 100 }
# :row_colors:  An array of row background colors which are used cyclicly.
# :align: Alignment of text in columns, for entire table (:center) or by column ({ 0 => :left, 1 => :center})
# :minimum_rows:  The minimum rows to display on a page, including header.

module Prawn
  module Html    
    class Fixer 
      module Table
        attr_accessor :tables, :table_obj, :header, :configure_table_options, :rows

        def table_marker 
          'TABLE'
        end
                
        def initialize
          @tables = []
          @table_obj = {}
        end

        def fix(html, doc)          
          doc.css('table').each do |table|
            
            configure(table)            
            fix_row(table)
            
            tables << table_obj
            self
          end

          html.replace_tags_marker!('table', table_marker) 
        end 

        def configure(table)
          table_obj = {}
          header = table_obj[:headers] = []            
          configure_table_options(table)
          rows = table_obj[:rows] = []
        end

        def fix_row(table)
          # header
          table.css('tr').each_with_index do |tr, index|
            if index == 0    
              tr.css('th').each do |th|
                th_hash = get_th_hash(th)
                header << th_hash
              end
              tr.css('td').each do |td|
                th_hash = get_th_hash(th)
                header << th_hash
              end
            else
              cells = []
              tr.css('td').each do |td|
                cells << td.inner_html
              end
              rows << cells
            end
          end
        end
        
        def configure_table_options(table) 
          cls = table['class'] || ""
          table_obj[:border_style] = (cls if cls.includes_any?(['grid', 'underline'])) || 'grid'
          table_obj[:align] = table['align'] || 'left'
          table_obj[:width] = (table['width'].to_i if table['width'])
          table_obj[:height] = (table['width'].to_i if table['height'])
          table_obj[:border_width] = (table['border'].to_i if table['border']) || 1
          table_obj[:nobreak] = (table['nobreak'] && (table['nobreak'] != 'false'))
        end 
        
        def self.get_th_hash(th)
          return {:title => th.inner_html || "?", :width => th['width'].to_i, :align => th['align']}
        end       
        
      end
    end
  end
end