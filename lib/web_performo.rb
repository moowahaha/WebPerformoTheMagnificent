require File.join(File.dirname(__FILE__), 'web_performo', 'result')
require 'socket'
include Socket::Constants
require 'selenium-webdriver'

class WebPerformo
  VERSION = '0.2'

  def initialize browser = 'firefox'
    @browser = browser.to_sym
  end

  def run url
    WebPerformo::Result.new(
            :url => url,
            :first_byte_speed => time_first_byte(url),
            :render_speed => time_render(url)
    )
  end

  private

  def time_first_byte url
    socket = Socket.new(AF_INET, SOCK_STREAM, 0)
    sockaddr = Socket.sockaddr_in(80, url.downcase.gsub(/^https?:\/\//, ''))

    begin
      socket.connect_nonblock(sockaddr)
    rescue Errno::EINPROGRESS
      IO.select(nil, [socket])
    end

    timer(socket) do |socket|
      socket.write( "GET / HTTP/1.0\r\n\r\n" )
      socket.readchar
    end
  end

  def time_render url
    selenium_driver = Selenium::WebDriver.for @browser

    time_elapsed = timer(selenium_driver, url.downcase =~ /^http:/ ? url : "http://#{url}") do |driver, url|
      driver.navigate.to(url)
    end

    selenium_driver.close
    time_elapsed
  end

  def timer *params
    before = Time.now.to_f
    yield *params
    Time.now.to_f - before
  end
end
