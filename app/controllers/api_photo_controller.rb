require 'uri'
require 'open-uri'
require 'json'
require 'net/http'

class ApiPhotoController < ApplicationController

  def request
    photo_raw = params[:photo]

    photo = photo_to_base64(photo_raw)

    plants_sug_raw = request_photo_api(photo)

    plants_sugs = plants_sug_raw["results"]["classification"]["suggestions"].first(3)

    name_sugs = []

    plants_sugs.each do |plant|
      name_sugs << plant["name"]
    end




  end

  private

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

      search_result = JSON.parse(url_open)["data"]
      

    end


  end
end
