require File.join(File.dirname(__FILE__), '..', 'lib', 'web_performo', 'result')

describe WebPerformo::Assertion do
  before do
    @slow_result = WebPerformo::Result.new(:render_speed => 3, :first_byte_speed => 4, :url => 'slow')
    @fast_result = WebPerformo::Result.new(:render_speed => 1, :first_byte_speed => 2, :url => 'fast')
  end

  it "should raise an exception when asserting fast is generally slower" do
    lambda {
      @fast_result.assert > @slow_result
    }.should raise_error "Failed asserting 'fast' > 'slow' (first byte 2 !> 4, render 1 !> 3)"
  end

  it "should raise an exception when asserting slow is generally faster" do
    lambda {
      @slow_result.assert < @fast_result
    }.should raise_error "Failed asserting 'slow' < 'fast' (first byte 4 !< 2, render 3 !< 1)"
  end

  it "should not raise an exception when asserting fast is faster" do
    (@fast_result.assert < @slow_result).should be_true
  end

  it "should not raise an exception when asserting slow is slower" do
    (@slow_result.assert > @fast_result).should be_true
  end
end
