# prawn-html ##

A complete redesign of my old `prawn-assist` library.  

This gem has the goal of making it much easier to convert HTML into suitable PDF with a lot of options.
I am not by any means a prawn expert, so please provide feedback with fixes, suggestions and ideas!

## Requirements ##

* HTML tidy (see http://github.com/alexdunae/tidy)
* css_parser 1.1.2 (http://github.com/kristianmandrup/css_parser)
* sanitize

To clean up the html and remove unwanted/needed parts for pdf generation, maybe:

http://raa.ruby-lang.org/project/whitewash/
http://wonko.com/post/sanitize

I think all the HTML text nodes of relevance (between the tags) should be encoded using the 'htmlentities' gem. Prawn supports UTF-8 characters!

http://github.com/threedaymonk/htmlentities/blob/master/test/entities_test.rb

Something like:

<pre>
# Add basic utf-8 encoding support (Ruby 1.8)
$KCODE = 'UTF8'

module Html
  def self.encode(input, *args)
    @coder ||= HTMLEntities.new;
    [xhtml1_entities, html4_entities].each do |coder|
       coder.encode(input, *args))
    end
  end
end

encoded_html = Html.encode(html)
</pre>

## Design ##

The generator will be designed top follow these steps:

1. HTML Tidy (see http://github.com/alexdunae/tidy)
2. Load HTML model using Nokogiri
2. Apply CSS style model on top of HTML model
2. Clean HTML model from certain tags
3. Normalize HTML escaping to UTF-8 chars using HTML entities (supported by Prawn)
4. Fix HTML for use with prawn-format
5. Build PDF Generator Model (tables, images, ...)
6. Walk through PDF Generator Model and execute Prawn instructions  

## CSS to PDF styles ##

See http://github.com/kristianmandrup/html_css_decorator

In order to using styling information from CSS stylesheets, the HTML can't be stripped before styles have been calculated for the HTML elements and saved.

The PDF generator should support a special set of css styles to indicate meta data for PDF generation/layout, such as the layout of multiple images or tables
in a special grid layout in the PDF document, thick borders, captions, page numbers, header/footer etc. (see Flying Saucer and iText for inspiration)

## Parsing the HTML ## 
The parser uses `nokogiri` for html parsing.
The generator uses `pdf-format` to layout simple HTML such as bold, italic, underline and other simple 'formatting'.
   
## Intended Use ##

<pre>
  # first put html into a string
  html = %q{
    ...
  }  

  other_html = %q{
    ...
  }  
</pre>

Then configure the generator
<pre>      
# define layout options for tags
# should have defaults according to stylesheets?  
# should be on stack as node-tree is iterated?
pdf.tags :h1 => { :font_size => "16pt", :font_weight => :bold }, 
         :h2 => { :font_size => "14pt", :font_style => :italic },
         :h3 => { :font_size => "12pt", :font_style => :italic },
         :title => { :font_size => "24pt", :font_style => :bold }

position_options = {:ypos => 60}
scale_options = {:line_height => 16, :font_size => 14}                                             
table_options = {:font_size => 10, :line_height => 20, :cell_width => 60}
image_options = {:captions => {:font_size => 12, :bold => false}, :border => :thick}
                          
Note: some of these options are just defaults used if no others apply.

node_options = {:table => table_options, :image => image_options}

# block_tags - add BREAK after rendering text!
parse_options = {:include => {:erase_tags => 'legend', :strip_tags => ['dl', 'dd', 'dt', 'dfn'], :exclude => {:erase_tags => 'h3+'}}

pdf_options => {:position => position_options, :scale => scale_options, :nodes => node_options}

options = {:parse_options => parse_options, :pdf_gen => pdf_options} 

pdf_generator = Prawn::Html::Generate.new(options)
</pre>

Then generate the PDF document!
<pre>

pdf_generator.create_pdf(html)

# adjust line height for next document, but otherwise reuse generator configuration!
pdf_generator.create_pdf(other_html, {:position => {:line_height => 12}})

</pre>


## Changelog ##

April 28, 2010:
* About 60% of refactoring complete, mostly in parser and fixer. It now compiles and runs.
* TODO: Need to integrate Tidy, CSS parser and HTML entities gems! perhaps also sanitize? 


April 6, 2010:
* About 50% of refactoring complete, mostly in parser and fixer. 
* Needs good testing suite using rspec or test-unit. 

## Note on Patches/Pull Requests ##
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright ##

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
