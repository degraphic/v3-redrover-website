#-----------------------------------------------------------------------------79
# Mock server for running tests
# (c) 2012 RedRover
#-------------------------------------------------------------------------------
require 'sinatra/base'

class MockServer < Sinatra::Base
  # ----------------------------------------------------------------------------
  # Mixins here that define the 3rd party behavior
  # ----------------------------------------------------------------------------
  
  # ----------------------------------------------------------------------------
  # Facilitate sending a message whenever any 3rd party call slips through the cracks;
  # we need to capture it and write a response for it
  # ----------------------------------------------------------------------------
  class EverythingPattern
    Match = Struct.new(:captures)
  
    def initialize
      @captures = Match.new([])
    end
  
    def match(str)
      @captures
    end
  end
  
  get EverythingPattern.new do
    escape_request(request)
  end
  
  post EverythingPattern.new do
    escape_request(request)
  end
  
  put EverythingPattern.new do
    escape_request(request)
  end
  
  delete EverythingPattern.new do
    escape_request(request)
  end
  
  def escape_request(request)
    puts "MOCK SERVER ESCAPE: #{request.request_method} #{request.url} #{request.body.print}"
  end
end
