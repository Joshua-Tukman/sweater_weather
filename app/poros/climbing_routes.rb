class ClimbingRoutes
  attr_reader :name,
              :type,
              :rating,
              :location,
              :distance_to_route
  def initialize(info, start_point)
    @start_point = start_point
    @lat_lon = {lat: info[:latitude], lon: info[:longitude]}
    @name = info[:name]
    @type = info[:type]
    @rating = info[:rating]
    @location = info[:location]
    @map_quest_service = MapQuestService.new  
    @distance_to_route = calculate_distance(@lat_lon, @start_point)
  end

  def calculate_distance(lat_lon, start_point)
    @map_quest_service.distance_apart(lat_lon, start_point)
  end
end 