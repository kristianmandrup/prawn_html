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


end
