# encoding: utf-8

require 'pry'
require 'rest-client'
require 'nokogiri'
require 'json'

params = {
  lat: 51.9606649,
  lon: 7.626134699999966,
  activityType: "RUN",
  location: "Münster"
}
#
sourceUrl = "http://runkeeper.com/search/routes/"
page = 1
found = true
links = []


while found do
  puts "fetching #{sourceUrl}#{page}"
  data = RestClient.post("#{sourceUrl}#{page}", params)
  doc = Nokogiri::HTML(data)
  current_links = doc.css(".avatar").map{ |avatar| avatar[:href] }
  found = !current_links.empty?
  links << current_links
  page += 1
end

users = links.flatten.uniq.map{ |link| link.gsub("/user/", "").gsub("/profile", "") }
users = { users: users.map{ |user| { name: user } } }

File.open("users.json","w") do |f|
  f.write(users.to_json)
end
