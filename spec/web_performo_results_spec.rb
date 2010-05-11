require File.join(File.dirname(__FILE__), '..', 'lib', 'web_performo', 'result')

describe WebPerformo::Result do
  it "should allow us to fetch data we sat" do
    result = WebPerformo::Result.new(:render_speed => 10, :first_byte_speed => 20, :url => 'bob')

    result.render_speed.should == 10
    result.first_byte_speed.should == 20
    result.url.should == 'bob'
  end

  describe 'comparing' do
    before do
      @slow_result = WebPerformo::Result.new(:render_speed => 2, :first_byte_speed => 2, :url => 'slow')
      @fast_result = WebPerformo::Result.new(:render_speed => 1, :first_byte_speed => 1, :url => 'fast')
    end

    it "should recognise results that are fast" do
      @fast_result.should < @slow_result
    end

    it "should recognise results that are slow" do
      @slow_result.should > @fast_result
    end
  end
end