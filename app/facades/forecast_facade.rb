class ForecastFacade
  attr_reader :location, :forecast, :id
  def initialize(location)
    @location = location_format(location)
    @map_quest_service = MapQuestService.new
    @weather_service = WeatherService.new
    @forecast = current_weather(lat_long_formatted)
    @id = nil
  end

  def lat_long_formatted
    @map_quest_service.lat_long(@location)
  end
  
  def current_weather(lat_long)
    if @location == {:error=>"Invalid City"}
      {:error=> "Invalid City"}
    elsif @location == {:error=>"Invalid State"}
      {:error=> "Invalid State"}
    else
      Forecast.new(@weather_service.forecast(lat_long))
    end 
  end

  def location_format(location)
    city = location.split(',')[0].capitalize
    state = location.split(',')[1].upcase
    validate_state(state)
    if validate_state(state) == {:error=>"Invalid State"}      
      {:error=>"Invalid State"}
    else 
      validate_city(city, state)
        if validate_city(city, state) == {:error=>"Invalid City"}
          {:error=>"Invalid City"}
        else   
          "#{city}, #{state}"
        end 
    end 
  end

  def validate_state(state)
    if CS.states(:us).include?(state.to_sym)
      state.to_s
    else
      Errors.new.invalid_state
    end
  end

  def validate_city(city, state)
    if CS.cities(state.to_sym, :us).include?(city)
      city
    else
      Errors.new.invalid_city
    end
  end    
end 