class PropertiesController < ApplicationController
  def create
    @collection = Collection.find(params[:collection_id])
    @property = Property.new(property_params)
    @property.collection = @collection

    if @property.save
      redirect_to collection_path(@collection), notice: "success"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @collection = Collection.find(params[:collection_id])
    @property = @collection.properties.find(params[:id])
    @property.destroy
    redirect_to collection_path(@collection), notice: "Property deleted"
  end

  def show
    @collection = Collection.find(params[:id])
    @properties = @collection.properties
  end

  private

  # def extract_property_id(url)
  #   # Extract ID from URL like https://www.idealista.com/pt/inmueble/12345678/
  #   match = url.match(/\/inmueble\/(\d+)/)
  #   match[1] if match
  # end

  # def fetch_property_data(property_id)
  #   require 'uri'
  #   require 'net/http'
  #   require 'json'

  #   url = URI("https://idealista7.p.rapidapi.com/propertydetails?propertyId=#{property_id}&location=pt&language=en")

  #   http = Net::HTTP.new(url.host, url.port)
  #   http.use_ssl = true

  #   request = Net::HTTP::Get.new(url)
  #   request["x-rapidapi-key"] = '88810938d8mshbd2ca5d8f05300bp17eaf3jsn0dfb38524df4'
  #   request["x-rapidapi-host"] = 'idealista7.p.rapidapi.com'

  #   response = http.request(request)

  #   if response.code == "200"
  #     JSON.parse(response.body)
  #   else
  #     Rails.logger.error("API Error: #{response.code} - #{response.body}")
  #     nil
  #   end
  # end


  def property_params
    params.require(:property).permit(:name, :url, :address, :price, :description, :typology, :garage, :elevator, :size)
  end
end
