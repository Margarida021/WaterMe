require 'open-uri'
require 'json'

# DESTROY ALL RECORDS IN THE DB

User.destroy_all
Plant.destroy_all
Division.destroy_all
PlantDivision.destroy_all
CareGuide.destroy_all

# CREATE AN USER

User.create(name: "Armindo", email: "admin@lewagon.pt", password: "123456")

# LOOK FOR ALL PLANTS

url = "https://perenual.com/api/species-list?page=1&key=#{ENV["PERENUAL_API"]}"

url_open = URI.open(url).read

all_plants = JSON.parse(url_open)["data"]


# POPULATING DB WITH PLANTS FROM PERENUAL API

all_plants.each.first(100) do |plant|

  new_plant = Plant.new(
    name: plant["common_name"],
    scientific_name: plant["scientific_name"][0],
    description: "Beautiful #{plant["common_name"]} plant",
    photo_url: plant["default_image"]["original_url"],
    watering_freq: plant["watering"],
    light_level: plant["sunlight"][0]
    perenual_id: plant["id"]
  )

  new_plant.save!

end

# LOOK FOR AND UPDATE DESCRIPTION OF THE PLANT & CREATE CARE GUIDE

plants = Plant.all

plants.each do |plant|

  # Look description

  perenual_id = plant.perenual_id

  url_detail_plant = "https://perenual.com/api/species/details/#{perenual_id}?key=#{ENV["PERENUAL_API"]}"

  url_detail_plant_open = URI.open(url_detail_plant).read

  plant_data = JSON.parse(url_detail_plant_open)

  plant.update(description: plant_data["description"])

  # Create care guide and look for it

  url_care_guide_plant = plant_data["care-guides"]

  url_care_guide_plant_open = URI.open(plant_data["care-guides"]).read

  plant_care_guide = JSON.parse(url_care_guide_plant_open)["data"][0]["section"]

  care_guide = CareGuide.new(
    watering: plant_care_guide[0]["description"],
    sunlight: plant_care_guide[1]["description"],
    pruning: plant_care_guide[2]["description"]
  )

  care_guide.plant = plant

  care_guide.save!
  
end
