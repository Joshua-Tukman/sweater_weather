class RoadtripSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :origin, :destination, :travel_time, :arrival_weather
end