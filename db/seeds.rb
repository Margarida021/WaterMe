require 'open-uri'
require 'json'

# DESTROY ALL RECORDS IN THE DB

User.destroy_all
Plant.destroy_all
Division.destroy_all
PlantDivision.destroy_all

# CREATE AN USER

User.create(name: "Armindo", email: "admin@lewagon.pt", password: "123456")

# POPULATING DB WITH PLANTS FROM PERENUAL API

url = "https://perenual.com/api/species-list?page=1&key=#{ENV["PERENUAL_API"]}"

url_open = URI.open(url).read

plants_data = JSON.parse(url_open)["data"]

first = plants_data.first

plant = Plant.new(
  name: first["common_name"],
  scientific_name: first["scientific_name"][0],
  description: 'nice plant',
  photo_url: first["default_image"]["original_url"],
  watering: first["watering"],
  light_level: first["sunlight"][0]
)

plant.save!

# LOOK FOR DETAILS OF THE PLANT

url_detail_plant = "https://perenual.com/api/species/details/#{first["id"]}?key=#{ENV["PERENUAL_API"]}"

url_detail_plant_open = URI.open(url_detail_plant).read

plant_data = JSON.parse(url_detail_plant_open)

plant.update(description: plant_data["description"])

# CARE GUIDE OF THE PLANT

# url_care_guide_plant = plant_data["care-guides"]

# url_care_guide_plant_open = URI.open(plant_data["care-guides"]).read

# plant_care_guide = JSON.parse(url_care_guide_plant_open)["data"][0]["section"]

# plant_care_guide.each do |guide|
#   puts guide["type"]
#   puts guide ["description"]
# end
