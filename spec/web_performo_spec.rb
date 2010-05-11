require File.join(File.dirname(__FILE__), '..', 'lib', 'web_performo')

describe WebPerformo do
  it "should tell me what url a result is based on" do
    result = WebPerformo.new.run('http://www.dcyder.com')
    result.url.should == 'http://www.dcyder.com'
  end

  describe 'first byte' do
    it "should give me the first-byte speed of dcyder.com (what a site!)" do
      fake_socket = stub('fake socket')
      Socket.should_receive(:new).and_return(fake_socket)

      fake_sockaddr = stub('fake socket address')
      Socket.should_receive(:sockaddr_in).with(80, 'www.dcyder.com').and_return(fake_sockaddr)
      fake_socket.should_receive(:connect_nonblock).with(fake_sockaddr)
      
      fake_socket.should_receive(:write).with(/GET/)
      fake_socket.should_receive(:readchar).and_return {sleep 0.5}

      performo = WebPerformo.new
      result = performo.run('http://www.dcyder.com')

      result.first_byte_speed.should > 0.5
      result.first_byte_speed.should < 0.7
    end
  end

  describe 'rendering' do
    it "should give me the render speed of dcyder.com (worth rendering, btw)" do
      fake_driver = stub('fake browser')
      Selenium::WebDriver.should_receive(:for).with(:fakeyfox).and_return(fake_driver)

      fake_navigator = stub('fake selenium navigator')
      fake_driver.should_receive(:navigate).and_return(fake_navigator)
      fake_navigator.should_receive(:to).with('http://www.dcyder.com').and_return {sleep 0.5}
      
      fake_driver.should_receive(:close)

      performo = WebPerformo.new('fakeyfox')
      result = performo.run('www.dcyder.com')

      result.render_speed.should > 0.5
      result.render_speed.should < 0.7
    end
  end
end