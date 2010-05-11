require File.join(File.dirname(__FILE__), '..', 'lib', 'web_performo')

describe WebPerformo do
  it "should give me the first-byte speed of dcyder.com (what a site!)" do
    performo = WebPerformo.new('http://www.dcyder.com')
    performo.first_byte.should > 0
  end
end