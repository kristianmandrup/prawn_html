# prawn-html ##

A complete redesign of my old prawn-assist.  

This gem has the goal of making it much easier to convert HTML into suitable PDF with a lot of options.
I am not by any means a prawn expert, so please provide feedback with fixes, suggestions and ideas!

The general design is the following.

1. Clean the HTML, removing tags that have no meaning for PDF generation, such as <script>, <head>, <meta> etc.
2. Optionally perform HTML Tidy on the document using a webservice (is there another means?)
3. Normalize HTML by converting eascpaed characters to valid UTF-8 chars. Which gem to use?
3. Fix the HTML, by inserting or replacing tags to conform with the use of prawn-format. 
3a. Insert breaks after block tags to force line break.
3b. Adjust lists
3c. Insert generator instructions for how to handle tables, images and other complex nodes
4. Generate PDF using HTML and generator instructions

The parser uses `nokogiri` for html parsing.
The generator uses `pdf-format` to layout simple HTML such as bold, italic, underline and other simple 'formatting'.

Would be nice to integrate with a css parser later, loading all referenced stylesheets and determine which rules apply to which tags and then
have the PDF reflect those styles. This could be a subproject!

The generator (should?) supports a special set of css styles to indicate meta info for the generation and layout process, such as laying out multiple images or tables
in a special grid layout in the PDF document, thick borders and captions etc. 
   
## Intended Use ##

<pre>
  # first put html into a string
  html = %q{
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
       "http://www.w3.org/TR/html4/strict.dtd">
    <html lang="en">
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    	<title>untitled</title>
    	<meta name="generator" content="TextMate http://macromates.com/">
    	<meta name="author" content="Kristian Mandrup">
    	<!-- Date: 2010-04-04 -->
    </head>
    <body>
      <h1>Hello World</h1>
    </body>
    </html>
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

April 6, 2010:
 - About 50% of refactoring complete, mostly in parser and fixer. 
 - Needs good testing suite using rspec or test-unit. 

== Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright ##

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
