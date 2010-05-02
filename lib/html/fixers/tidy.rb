require 'tidy'
Tidy.path = '~/tidy_mosx/tidy' # or where ever your tidylib resides

my_nasty_html_string = '<b><p>blip</b></p>'

nice_html = ""
Tidy.open(:show_warnings=>true) do |tidy|
  tidy.options.output_xhtml = true
  tidy.options.wrap = 0
  tidy.options.indent = 'auto'
  tidy.options.indent_attributes = false
  tidy.options.indent_spaces = 4
  tidy.options.vertical_space = false
  tidy.options.char_encoding = 'utf8'
  nice_html = tidy.clean(my_nasty_html_string)
end

# remove excess newlines
nice_html = nice_html.strip.gsub(/\n+/, "\n")
puts nice_html