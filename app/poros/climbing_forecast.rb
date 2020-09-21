class ClimbingForecast
  attr_reader :lat_lon, :summary, :temp
  def initialize(info)
    @lat_lon = {lat: info[:lat], lon: info[:lon]}
    @temp = info[:current][:temp]
    @summary = info[:current][:weather].first[:description].capitalize
  end

 
end
