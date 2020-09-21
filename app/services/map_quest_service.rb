class MapQuestService

  def lat_long(location)
    response = get_json("/geocoding/v1/address?location=#{location}")
    {lat: latitude(response), lon: longitude(response)}
  end

  def distance_apart(finish, start)
    start_lat = start[:lat]
    start_lon = start[:lon]
    finish_lat = finish[:lat]
    finish_lon = finish[:lon]
    get_json("/directions/v2/route?from=#{start_lat},#{start_lon}&to=#{finish_lat},#{finish_lon}")[:route][:legs].first[:distance]
  end 
  
  private

  def latitude(info)
    info[:results].first[:locations].first[:latLng][:lat]
  end 

  def longitude(info)
    info[:results].first[:locations].first[:latLng][:lng]
  end 

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("http://www.mapquestapi.com") do |faraday|
      faraday.params['key'] = ENV['MAP_QUEST_KEY']
      faraday.params['thumbMaps'] = false
      faraday.params['maxResults'] = 1
    end 
  end
end 