require 'date'
class Forecast
  attr_reader :time, 
              :current_temp, 
              :feels_like,
              :humidity,
              :visibility,
              :uv_index,
              :sunrise,
              :sunset,
              :high_temp,
              :low_temp,
              :hourly,
              :five_day_forecast

  def initialize(weather_info)
    @time = day_time(weather_info[:current][:dt])
    @current_temp = weather_info[:current][:temp].to_i
    @feels_like = weather_info[:current][:feels_like].to_i
    @humidity = weather_info[:current][:humidity]
    @visibility = weather_info[:current][:visibility]
    @uv_index = weather_info[:current][:uvi].to_i
    @sunrise = Time.at(weather_info[:current][:sunrise]).strftime('%-I:%M %p')
    @sunset = Time.at(weather_info[:current][:sunset]).strftime('%-I:%M %p')
    @high_temp = weather_info[:daily][0][:temp][:max].to_i
    @low_temp = weather_info[:daily][0][:temp][:min].to_i
    @hourly = hourly_forcast(weather_info[:hourly][0..23])
    @five_day_forecast = five_day_forecast(weather_info[:daily][1..5])
  end

  def hourly_forcast(report)
    report.map{|day_info| HourlyForecast.new(day_info)}
  end

  def day_time(utc)
    Time.at(utc).strftime('%-I:%M %p, %B %-d')
  end

  def five_day_forecast(info)
   info.map{|day_info| FiveDayForecast.new(day_info)}
  end

end