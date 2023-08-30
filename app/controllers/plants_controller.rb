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

    elsif params[:photo].present?

      photo_raw = params[:photo]

      photo = photo_to_base64(photo_raw)

      plants_sug_raw = request_photo_api(photo)

      plants_sugs = plants_sug_raw["results"]["classification"]["suggestions"].first(3)

      name_sugs = []

      plants_sugs.each do |plant|
        name_sugs << plant["name"]
      end

      @plants = request_perenual_api(name_sugs)

    end
  end

  def show
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
    request["Api-Key"] = ENV.fetch["PLANT_ID_API"]
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
  end

  def request_perenual_api(plant_names_sugs)
    plant_objects = []

    plant_names_sugs.each do |plant|
      url = "https://perenual.com/api/species-list?key=#{ENV["PERENUAL_API"]}&q=#{plant}"

      url_open = URI.open(url).read

      # This have first 3 for simplicity

      search_results = JSON.parse(url_open)["data"].first(3)

      search_results.each do |result|
        plant_name = result["common_name"]
        plant_scientific_name = result["scientific_name"]
        plant_photo = result["default_image"]["original_url"]
        plant_perenual_id = result["id"]
        plant_objects << { name: plant_name, scientific_name: plant_scientific_name, photo_url: plant_photo, perenual_id: plant_perenual_id, id: 1 }
      end
    end

    plant_objects
  end
end
