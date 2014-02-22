# encoding: utf-8

require 'pry'
require 'rest-client'
require 'nokogiri'
require 'json'

baseSourceUrl = "http://www.runtastic.com/routes/"

route_ids = []

(1..86).each do |i|
  contents = JSON(File.read("routes_#{i}.json"))
  contents['routes'].each do |route|
    route_ids << route['id']
  end
end

geojson = { "type" => "FeatureCollection", "features" => [] }
def feature
  { "type" => "Feature", "geometry" => { "type" => "LineString", "coordinates" => [] }, "properties" => {}}
end

route_ids.each do |id|
  puts "fetching #{id}"
puts "#{baseSourceUrl}#{id}/traces/route_trace.json"
  route_data = JSON(RestClient.get("#{baseSourceUrl}#{id}/traces/route_trace.json"))
  route_coords = []
  route_data.each do |point|
    route_coords << [point['longitude'],point['latitude']]
  end
  curr_feature = feature
  curr_feature['geometry']['coordinates'] = route_coords
  geojson['features'] << curr_feature

end

File.open("geojson.json","w") do |f|
  f.write(geojson.to_json)
end
