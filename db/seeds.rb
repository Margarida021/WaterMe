require 'open-uri'
require 'json'

# DESTROY ALL RECORDS IN THE DB

User.destroy_all
Plant.destroy_all
Division.destroy_all
PlantDivision.destroy_all

# CREATE AN USER

User.create(name: "Armindo", email: "admin@lewagon.pt", password: "123456")

# POPULATING DB WITH PLANTS FROM TREFLE API

url = "https://perenual.com/api/species-list?page=1&key=#{ENV["PERENUAL_API"]}"

url_open = URI.open(url).read

plants_data = JSON.parse(url_open)["data"]

first = plants_data.first

plant = Plant.new(
  name: first["common_name"],
  scientific_name: first["scientific_name"][0],
  description: 'nice plant :)',
  photo_url: first["default_image"]["original_url"],
  watering: first["watering"],
  light_level: first["sunlight"][0]
)

plant.save!

p plants_data.first
