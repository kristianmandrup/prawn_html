require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "PrawnHtml" do
  it "should include certain strip tags" do
     Prawn::Html::Cleaner.new(:include => {:strip_tags => 'h1' }, :exclude => {:erase_tags => 'table' })
  end

  it "should exclude certain strip tags" do
    
  end

  it "should include certain erase tags" do
    
  end

  it "should exclude certain erase tags" do
    
  end

  it "should work" do
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

    cleaner = Prawn::Html::Cleaner.new(:include => {:strip_tags => 'h1' }, :exclude => {:erase_tags => 'table' })
    puts cleaner.custom_strip_tags.inspect
    puts cleaner.custom_erase_tags.inspect  

    clean_html = cleaner.clean(html)
    puts clean_html

    fixer = Prawn::Html::Fixer.new(:include => {:block_tags => 'h1' }, :exclude => {:block_tags => ['h3', 'div'] })

    fixed_html = fixer.fix(clean_html)
    puts fixed_html
    
  end
end
