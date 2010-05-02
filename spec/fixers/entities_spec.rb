# use require-me!
require 'require-me'
require Folder.require_rel 'spec_helper'

describe "HtmlEntities" do
  it "should encode" do
    string = "<élan>"
    puts Html.encode(string)               # => "&lt;élan&gt;"
    puts Html.encode(string, :named)       # => "&lt;&eacute;lan&gt;"
    puts Html.encode(string, :decimal)     # => "&#60;&#233;lan&#62;"
    puts Html.encode(string, :hexadecimal) # => "&#x3c;&#xe9;lan&#x3e;"
  end

  it "should decode" do
    html = "<b>&amp;</b>"
    decoded_html = Html.decode(html)
    puts decoded_html
  end
end

