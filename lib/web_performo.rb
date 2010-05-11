require File.join(File.dirname(__FILE__), 'web_performo', 'result')
require 'socket'
include Socket::Constants
require 'selenium-webdriver'

class WebPerformo
  VERSION = '0.0.1'

  def initialize browser = 'firefox'
    @browser = browser.to_sym
  end

  def run url
    socket = Socket.new(AF_INET, SOCK_STREAM, 0)
    sockaddr = Socket.sockaddr_in(80, url.downcase.gsub(/^https?:\/\//, ''))

    begin
      socket.connect_nonblock(sockaddr)
    rescue Errno::EINPROGRESS
      IO.select(nil, [socket])
    end
    
    before = Time.now.to_f
    socket.write( "GET / HTTP/1.0\r\n\r\n" )
    socket.readchar
    first_byte_elapsed = Time.now.to_f - before

    selenium_driver = Selenium::WebDriver.for @browser
    before = Time.now.to_f
    selenium_driver.navigate.to(url)
    render_elapsed = Time.now.to_f - before
    selenium_driver.close

    WebPerformo::Result.new(
            :url => url,
            :first_byte_speed => first_byte_elapsed,
            :render_speed => render_elapsed
    )
  end
end