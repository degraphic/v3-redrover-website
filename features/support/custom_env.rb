#-----------------------------------------------------------------------------79
# Custom cucumber environment
# (c) 2012 RedRover
#-------------------------------------------------------------------------------
require Rails.root.join('spec/support/mock_server/mock_server')

# Configure the driver based on profile or environment variables
%w(chrome firefox safari).each do |browser|
  browser = browser.to_sym
  Capybara.register_driver browser do |app|
    Capybara::Selenium::Driver.new(app, :browser => browser)
  end
end

driver = if ENV['BROWSER']
  ENV['BROWSER'].to_sym
else
  :webkit
end

driver  = :chrome

Capybara.current_driver = Capybara.default_driver = Capybara.javascript_driver = driver

# Implement pause behavior for debugging
if ENV['PAUSE']
  After do
    print "Press Return to continue"
    STDIN.getc
  end
end

#
# Use Artifice to mock 3rd party server responses
#

# Maintain separate HTTP for Capybara and Selenium
# http://matschaffer.com/2011/04/net-http-mock-cucumber/
module Selenium
  Net = ::Net.dup
  module Net
    suppress_warnings { HTTP = Artifice::NET_HTTP }
  end
end

class Capybara::Server
  Net = ::Net.dup
  module Net
    suppress_warnings { HTTP = Artifice::NET_HTTP }
  end
end

# Use fake remote sites except if otherwise tagged with @real-remote
Around('~@real-remote') do |scenario, block|
  Artifice.activate_with(MockServer) do
    block.call
  end
end
Capybara.server_port = 3333
Capybara.app_host = "http://localhost:#{Capybara.server_port}"

# Start a mock remote server we can use for testing
sinatra_env = {"RAILS_URL" => "http://localhost:#{Capybara.server_port}"}
sinatra_cmd = "ruby #{Rails.root.join('features/support/api_server.rb')}"

sinatra_pid = spawn(sinatra_env, sinatra_cmd, [:out, :err]=>["log/test.sinatra.log", "w+"])
puts "Launched Sinatra: #{sinatra_pid}"
sleep(5)
at_exit do
  Process.kill("INT", sinatra_pid)
  Process.wait(sinatra_pid)
end

Capybara.server_boot_timeout = 120
Capybara.default_wait_time = 30
