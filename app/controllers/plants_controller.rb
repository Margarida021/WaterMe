require 'uri'
require 'open-uri'
require 'json'
require 'net/http'

class PlantsController < ApplicationController
  before_action :set_plant, only: %i[show]

  def index
    if params[:query] == 'from_api' && params[:plants_sugs].present?
      @plants = params[:plants_sugs]
    elsif params[:query].present?
      sql_subquery = "name ILIKE :query OR scientific_name ILIKE :query"
      @plants = @plants.where(sql_subquery, query: "%#{params[:query]}%")
    else
      @plants = Plant.all
    end
  end

  def show
  end

  def create
    perenual_id = params[:perenual_id]
    @plant = plant_creation(perenual_id)

    redirect_to plant_path(@plant)
  end

  def api
    if params[:photo].present?
      photo_raw = params[:photo]

      photo = photo_to_base64(photo_raw)

      plants_sug_raw = request_photo_api(photo)

      plants_sugs = plants_sug_raw["result"]["classification"]["suggestions"].first(3)

      name_sugs = []

      plants_sugs.each do |plant|
        name_sugs << plant["name"]
      end

      @plants_sugs = req_perenual_api_name_image(name_sugs)

      redirect_to plants_path(query: 'from_api', plants_sugs: @plants_sugs)
    end
  end

  private

  def set_plant
    @plant = Plant.find(params[:id])
  end

  def photo_to_base64(plant_photo)
    Base64.encode64(plant_photo.read)
  end

  def request_photo_api(photo64)
    url = URI("https://plant.id/api/v3/identification")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Api-Key"] = ENV["PLANT_ID_API"]
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
      "images": [
        photo64
      ],
      "latitude": 49.207,
      "longitude": 16.608,
      "similar_images": true
    })

    response = https.request(request).read_body
    parsed_response = JSON.parse(response)

    parsed_response
  end

  def req_perenual_api_name_image(plant_names_sugs)
    plant_objects = []

    plant_names_sugs.each do |plant|
      url = "https://perenual.com/api/species-list?key=#{ENV["PERENUAL_API"]}&q=#{plant}"

      url_open = URI.open(url).read

      # This have first 1 for simplicity (Im creating a hash first because there could be a better way to do this without create plants at first)

      search_results = JSON.parse(url_open)["data"].first(1)

      search_results.each do |result|
        plant_name = result["common_name"].capitalize
        plant_scientific_name = result["scientific_name"][0]
        plant_photo = photo_null?(result["default_image"])
        # plant_watering_freq = result["watering"]
        # plant_light_level = result["sunlight"][0]
        plant_perenual_id = result["id"]
        plant_objects << { name: plant_name, scientific_name: plant_scientific_name, photo_url: plant_photo, perenual_id: plant_perenual_id }
      end
    end

    plant_objects
  end

  def plant_creation(perenual_id)
    url_detail_plant = "https://perenual.com/api/species/details/#{perenual_id}?key=#{ENV["PERENUAL_API"]}"

    url_detail_plant_open = URI.open(url_detail_plant).read

    plant_data = JSON.parse(url_detail_plant_open)

    sec_data = {
      name: plant_data["common_name"].capitalize,
      scientific_name: plant_data["scientific_name"][0],
      description: plant_data["description"],
      water_frequency: WaterFrequency.find_by(frequency: plant_data["watering"]),
      light_level: plant_data["sunlight"][0].capitalize,
      photo_url: photo_null?(plant_data["default_image"])
    }

    plant = Plant.create_with(sec_data).find_or_create_by(perenual_id: perenual_id)

    # Create care guide and look for it
    careguide_create(plant_data["care-guides"], plant)

    plant
  end

  def careguide_create(url_careguide, plant)
    url_care_guide_plant_open = URI.open(url_careguide).read

    plant_care_guide = JSON.parse(url_care_guide_plant_open)["data"][0]["section"]

    care_guide = CareGuide.new(
      watering: plant_care_guide[0]["description"],
      sunlight: plant_care_guide[1]["description"],
      pruning: plant_care_guide[2]["description"]
    )

    care_guide.plant = plant

    care_guide.save
  end

  def photo_null?(plant_photo)
    photo = ""

    if plant_photo.nil?
      photo = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
    else
      photo = plant_photo["original_url"]
    end

    photo
  end
end
