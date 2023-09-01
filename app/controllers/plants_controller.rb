require 'uri'
require 'open-uri'
require 'json'
require 'net/http'

class PlantsController < ApplicationController
  before_action :set_plant, only: %i[show]

  def index
    @plants = Plant.all

    if params[:query].present?
      sql_subquery = "name ILIKE :query OR scientific_name ILIKE :query"
      @plants = @plants.where(sql_subquery, query: "%#{params[:query]}%")
    end

    # elsif params[:photo].present?

    #   photo_raw = params[:photo]

    #   photo = photo_to_base64(photo_raw)

    #   plants_sug_raw = request_photo_api(photo)

    #   plants_sugs = plants_sug_raw["results"]["classification"]["suggestions"].first(3)

    #   name_sugs = []

    #   plants_sugs.each do |plant|
    #     name_sugs << plant["name"]
    #   end

    #   @plants = request_perenual_api(name_sugs)
    # end
  end

  def show
  end

  def create
    if params[:photo].present?
      photo_raw = params[:photo]

      photo = photo_to_base64(photo_raw)

      plants_sug_raw = request_photo_api(photo)

      plants_sugs = plants_sug_raw["result"]["classification"]["suggestions"].first(1)

      name_sugs = []

      plants_sugs.each do |plant|
        name_sugs << plant["name"]
      end

      @plants = request_perenual_api(name_sugs)
      #ESTE RENDER NÃO ESTA A FUNCIONAR
      render partial: 'components/last_plants_created', locals: { plants: @plants }
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

  def request_perenual_api(plant_names_sugs)
    plant_objects = []

    plant_names_sugs.each do |plant|
      url = "https://perenual.com/api/species-list?key=#{ENV["PERENUAL_API"]}&q=#{plant}"

      url_open = URI.open(url).read

      # This have first 1 for simplicity (Im creating a hash first because there could be a better way to do this without create plants at first)

      search_results = JSON.parse(url_open)["data"].first(1)

      search_results.each do |result|
        plant_name = result["common_name"]
        plant_scientific_name = result["scientific_name"][0]
        plant_photo = photo_null?(result["default_image"])
        plant_watering_freq = result["watering"]
        plant_light_level = result["sunlight"][0]
        plant_perenual_id = result["id"]
        plant_objects << { name: plant_name, scientific_name: plant_scientific_name, photo_url: plant_photo, perenual_id: plant_perenual_id, watering_freq: plant_watering_freq, light_level: plant_light_level }
      end
    end

    plants_created = 0

    plant_objects.each do |plant|
      sec_data = {
        name: plant[:name].capitalize,
        scientific_name: plant[:scientific_name],
        description: "Beautiful plant",
        watering_freq: plant[:watering_freq],
        light_level: plant[:light_level],
        photo_url: plant[:photo_url]
      }
      Plant.create_with(sec_data).find_or_create_by(perenual_id: plant[:perenual_id])
      plants_created += 1 if Plant.create_with(sec_data).find_or_create_by(perenual_id: plant[:perenual_id])
    end

    last_plants = Plant.last(plants_created)

    care_guide_desc_creation(last_plants)

    last_plants
  end

  def care_guide_desc_creation(plants_created)
    # Look description

    plants_created.each do |plant|
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

      care_guide.save
    end
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
