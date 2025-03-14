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

  def property_params
    params.require(:property).permit(:name, :url, :address, :price, :description, :typology, :garage, :elevator, :size)
  end
end
