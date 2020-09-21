class MountainProjectService

  def find_routes(lat_lon)
    get_json("/data/get-routes-for-lat-lon?lat=#{lat_lon[:lat]}&lon=#{lat_lon[:lon]}")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://www.mountainproject.com") do |f|
      f.params['key'] = ENV['MOUNTAIN_PROJECT_KEY']
    end 
  end
end
#https://www.mountainproject.com/data/get-routes-for-lat-lon?lat=40.03&lon=-105.25&maxDistance=10&minDiff=5.6&maxDiff=5.10&key=200771304-3198310c03cc10794f6c76581205e187