require 'date'
class FiveDayForecast
  attr_reader :day,
              :description,
              :rain,
              :snow,
              :precipitation,
              :high_temp,
              :low_temp
  def initialize(data)
    @day = Time.at(data[:dt]).strftime('%A')
    @description = data[:weather].first[:main]
    @rain = rain_check(data)
    @snow = snow_check(data)
    @precipitation = rain_check(data)['rain'] + snow_check(data)['snow']
    @high_temp = data[:temp][:max].to_i
    @low_temp = data[:temp][:min].to_i
  end

  def rain_check(data)
    if data[:rain].nil?
       { 'rain' => 0 }
    else
      { 'rain' => data[:rain] } 
    end    
  end
  
  def snow_check(data)
    if data[:snow].nil?
       { 'snow' => 0 }
    else
      { 'snow' => data[:snow] }
    end 
  end 
end