require 'date'
class HourlyForecast
  attr_reader :temp,
              :time
  def initialize(info)
    @temp = info[:temp].to_i
    @time = Time.at(info[:dt]).strftime('%-I %p')
  end
end 