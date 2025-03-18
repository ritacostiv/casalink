class PropertiesController < ApplicationController
  def create
    @collection = Collection.find(params[:collection_id])
    @property = Property.new(property_params)
    @property.collection = @collection
    @property.user = current_user

    if @property.save
      create_event(:property_creation)
      redirect_to collection_path(@collection), notice: "success"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @collection = Collection.find(params[:collection_id])
    @property = @collection.properties.find(params[:id])
    create_event(:property_deletion)
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

  def update
    @collection = Collection.find(params[:collection_id])
    @property = @collection.properties.find(params[:id])
    if @property.update(property_params)
      create_event(:property_update)
      redirect_to collection_path(@collection), notice: "Property updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def property_params
    params.require(:property).permit(:name, :url, :address, :price, :description, :typology, :garage, :elevator, :size)
  end

  def create_event(event_type)
    Event.create(
      user_id: current_user.id,
      property: @property,
      user_first_name: current_user.first_name,
      user_last_name: current_user.last_name,
      property_name: @property.name,
      url: @property.url,
      collection_name: @collection.name,
      collection_url: "/collections/#{@collection.id}",
      event_type: event_type
    )
  end
end
