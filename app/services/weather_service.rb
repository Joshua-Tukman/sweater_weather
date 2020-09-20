class WeatherService

  def forecast(lat_long)
    params = lat_long
    response = get_json("/data/2.5/onecall", params)
  end

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.openweathermap.org") do |faraday|
      faraday.params['appid'] = ENV['OPEN_WEATHER_API_KEY']
      faraday.params['exclude'] = 'minutely'
      faraday.params['units'] = 'imperial'
    end 
  end
end 