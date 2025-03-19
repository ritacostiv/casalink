class PropertiesController < ApplicationController
  def create
    @collection = Collection.find(params[:collection_id])
    @property = Property.new(property_params)
    @property.collection = @collection
    @property.user = current_user

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

  def edit
    @collection = Collection.find(params[:collection_id])
    @property = @collection.properties.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def filter_options
    @prices = Property.pluck(:price).uniq.sort
    @sizes = Property.pluck(:size).uniq.sort
    @typologies = Property.pluck(:typology).uniq.sort
    @ratings = Property.pluck(:rating).uniq.sort

    render json: {
      prices: @prices,
      sizes: @sizes,
      typologies: @typologies,
      ratings: @ratings
    }
  end

  def index
    @properties = Property.all

    # Apply filters dynamically
    @properties = @properties.where("price >= ?", params[:min_price]) if params[:min_price].present?
    @properties = @properties.where("price <= ?", params[:max_price]) if params[:max_price].present?
    @properties = @properties.where("size >= ?", params[:min_size]) if params[:min_size].present?
    @properties = @properties.where("size <= ?", params[:max_size]) if params[:max_size].present?
    @properties = @properties.where(typology: params[:typology]) if params[:typology].present?
    @properties = @properties.where(elevator: true) if params[:elevator].present? && params[:elevator] == "true"
    @properties = @properties.where(garage: true) if params[:garage].present? && params[:garage] == "true"

    respond_to do |format|
      format.html
      format.js { render partial: "properties/list", locals: { properties: @properties } }
    end
  end



  def update
    @collection = Collection.find(params[:collection_id])
    @property = @collection.properties.find(params[:id])
    if @property.update(property_params)
      redirect_to collection_path(@collection), notice: "Property updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def property_params
    params.require(:property).permit(:name, :url, :address, :price, :description, :typology, :garage, :elevator, :size)
  end
end
