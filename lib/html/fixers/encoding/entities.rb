# Use htmlentities gem to convert to UTF-8 characters
require 'htmlentities'

module Html
  class << self
    attr_accessor :coder
  end

  # :named, :decimal, :hexadecimal
  def self.encode(input, *args)
    @coder ||= HTMLEntities.new('html4');
    self.coder.encode(input, *args)
  end

  def self.decode(input, *args)
    @coder ||= HTMLEntities.new('html4');
    self.coder.decode(input, *args)
  end

end
