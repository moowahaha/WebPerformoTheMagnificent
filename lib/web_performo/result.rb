require File.join(File.dirname(__FILE__), 'assertion')

class WebPerformo
  class Result
    attr_reader :first_byte_speed, :render_speed, :url
    
    def initialize result
      @url, @first_byte_speed, @render_speed = result[:url], result[:first_byte_speed], result[:render_speed]
    end

    def > candidate
      self.first_byte_speed > candidate.first_byte_speed && self.render_speed > candidate.render_speed
    end

    def < candidate
      self.first_byte_speed < candidate.first_byte_speed && self.render_speed < candidate.render_speed
    end

    def assert
      WebPerformo::Assertion.new(self)
    end
  end
end