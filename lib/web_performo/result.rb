class WebPerformo
  class Result
    attr_reader :first_byte_speed, :render_speed, :url
    
    def initialize result
      @url, @first_byte_speed, @render_speed = result[:url], result[:first_byte_speed], result[:render_speed]
    end
  end
end