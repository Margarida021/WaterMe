require 'uri'
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

    if params[:photo].present?
      raise
      redirect_to api_path(params[:photo])
      @plants = photo_search(params[:photo])
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

  def photo_search(plant_photo)
    photo64 = photo_to_base64(plant_photo)

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

    response = https.request(request)
    puts response.read_body
  end
end
