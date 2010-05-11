class WebPerformo
  class Assertion
    def initialize result
      @result = result
    end

    def > candidate
      errors = []

      errors << "first byte #{@result.first_byte_speed} !> #{candidate.first_byte_speed}" if @result.first_byte_speed <= candidate.first_byte_speed
      errors << "render #{@result.render_speed} !> #{candidate.render_speed}" if @result.render_speed <= candidate.render_speed

      format_errors '>', candidate, errors
    end

    def < candidate      
      errors = []

      errors << "first byte #{@result.first_byte_speed} !< #{candidate.first_byte_speed}" if @result.first_byte_speed >= candidate.first_byte_speed
      errors << "render #{@result.render_speed} !< #{candidate.render_speed}" if @result.render_speed >= candidate.render_speed

      format_errors '<', candidate, errors
    end

    private

    def format_errors operator, candidate, errors
      return true if errors.length == 0
      
      error_msg = "Failed asserting '#{@result.url}' #{operator} '#{candidate.url}'"

      raise "#{error_msg} (#{errors.join(', ')})"
    end
  end
end