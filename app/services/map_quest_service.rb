class MapQuestService

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