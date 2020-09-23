class MapQuestService

  def drive_time(start, finish)
    origin = [start[:lat],start[:lon]].join(",")
    destination = [finish[:lat],finish[:lon]].join(",")
    
    get_json("/directions/v2/route?from=#{origin}&to=#{destination}")[:route][:formattedTime]
  end 

  def lat_long(location)
    response = get_json("/geocoding/v1/address?location=#{location}")
    {lat: latitude(response), lon: longitude(response)}
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