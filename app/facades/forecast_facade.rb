class ForecastFacade
  def initialize(location)
    @location = location
    @map_quest_service = MapQuestService.new
    @weather_service = WeatherService.new
    @lat_long = lat_long_formatted
    @weather = current_weather(lat_long_formatted)
  end

  def lat_long_formatted
    @map_quest_service.lat_long(@location)
  end
  
  def current_weather(lat_long)
    Forecast.new(@weather_service.forecast(lat_long))
  end
   
end 