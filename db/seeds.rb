require 'open-uri'
require 'json'
# DESTROY ALL RECORDS IN THE DB
puts "Reseting DataBase"
User.destroy_all
Plant.destroy_all
Division.destroy_all
PlantDivision.destroy_all
CareGuide.destroy_all
WaterFrequencyWeekday.destroy_all
Weekday.destroy_all
WaterFrequency.destroy_all
puts "DataBase Reseted"

# CREATE AN USER
puts "Creating user"
User.create(name: "Armindo", email: "admin@lewagon.pt", password: "123456")
puts "User created"

# CREATE 2 DIVISIONS
puts "Creating division"
Division.create(name: "Mi Baranda", category: 'Balcony', light_direction: 'Full sun', user_id: User.last)
Division.create(name: "Mi Cuarto", category: 'Bedroom', light_direction: 'Shade', user_id: User.last)
puts "Division created"

# CREATE 3 WATER FREQUENCIES
puts "Creating waterfrequency"
sunday = Weekday.create(day: "Sunday")
monday = Weekday.create(day: "Monday")
tuesday = Weekday.create(day: "Tuesday")
wednesday = Weekday.create(day: "Wednesday")
thursday = Weekday.create(day: "Thursday")
friday = Weekday.create(day: "Friday")
saturday = Weekday.create(day: "Saturday")

frequent = WaterFrequency.create(frequency: "Frequent")
frequent_monday = WaterFrequencyWeekday.create(water_frequency: frequent, weekday: monday)
frequent_wednesday = WaterFrequencyWeekday.create(water_frequency: frequent, weekday: wednesday)
frequent_friday = WaterFrequencyWeekday.create(water_frequency: frequent, weekday: friday)

moderate = WaterFrequency.create(frequency: "Moderate")
moderate_monday = WaterFrequencyWeekday.create(water_frequency: moderate, weekday: monday)
moderate_wednesday = WaterFrequencyWeekday.create(water_frequency: moderate, weekday: wednesday)

average = WaterFrequency.create(frequency: "Average")
average_monday = WaterFrequencyWeekday.create(water_frequency: average, weekday: monday)

puts "Created waterfrequency"

# LOOK FOR ALL PLANTS

url = "https://perenual.com/api/species-list?page=1&key=#{ENV["PERENUAL_API"]}"

url_open = URI.open(url).read

all_plants = JSON.parse(url_open)["data"]

# POPULATING DB WITH PLANTS FROM PERENUAL API
def photo_null?(plant_photo)
  photo = ""

  if plant_photo.nil?
    photo = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
  else
    photo = plant_photo["original_url"]
  end

  photo
end

puts "generating new seeds"
all_plants.first(25).each do |plant|
  plant_photo = photo_null?(plant["default_image"])

  new_plant = Plant.new(
    name: plant["common_name"],
    scientific_name: plant["scientific_name"][0],
    description: "Beautiful #{plant["common_name"]} plant",
    photo_url: plant_photo,
    water_frequency: WaterFrequency.find_by(frequency: plant["watering"]),
    light_level: plant["sunlight"][0],
    perenual_id: plant["id"]
  )

  new_plant.save
  puts "#{new_plant.name} created"
end
puts "seeds generated"
# LOOK FOR AND UPDATE DESCRIPTION OF THE PLANT & CREATE CARE GUIDE

plants = Plant.all

puts "generating care guide"
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
puts "care guide generated"
