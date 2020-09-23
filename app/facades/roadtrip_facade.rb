require 'date'
class RoadtripFacade
  attr_reader :origin,
              :destination,
              :travel_time,
              :arrival_weather,
              :id
  def initialize(origin, destination)
    @origin = origin
    @destination = destination  
    @travel_time = drive_time(location_format(@origin), location_format(@destination))
    @arrival_weather = arrival_forecast(@destination, @travel_time)
    @id = nil
  end

  def drive_time(start, finish)
    unless start.class == Hash || finish.class == Hash
      service = MapQuestService.new
      origin = service.lat_long(start)
      destination = service.lat_long(finish)
      time = service.drive_time(origin, destination)
    end
    if start.class == Hash
      time = start
    elsif finish.class == Hash
      time = finish
    end
    time
  end

  def arrival_forecast(destination, travel_time)
    unless @travel_time.class == Hash
      arrival_location = MapQuestService.new.lat_long(destination)
      forecast = WeatherService.new.forecast(arrival_location)[:hourly]
      hours = format_time(@travel_time)
      weather_description = forecast[hours][:weather].first[:description].capitalize
      temp = forecast[hours][:temp].to_i
      forecast = {forecast: weather_description, temp: temp}
    end
  end
  
  def location_format(location)
    city = location.split(',')[0].titleize
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
  
  def format_time(time)
    unless @travel_time.class == Hash
      hours_min = time.delete(":")[0..3]
      hours = hours_min[0..1].to_i
      min = hours_min[2..3].to_i
      if min > 30 
        total_time = hours + 1
      elsif min < 30 && hours >= 1
        total_time = hours
      else
        total_time = 0
      end
      total_time
    end 
  end
end