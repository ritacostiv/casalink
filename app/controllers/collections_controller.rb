class CollectionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @collections = Collection.all
    @collection = Collection.new
  end

  def create
    @collections = Collection.all
    @collection = Collection.new(collection_params)
    @collection.user = current_user

    if @collection.save
      redirect_to collection_path(@collection), notice: "success"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @collection = Collection.find(params[:id])
    @properties = @collection.properties.order(created_at: :desc) # Instead of loading all properties, load only those belonging to the collection
    @property = Property.new
    #@properties = Property.all
    #@collection.user = current_user #<-- Remove this line if you didn't mean to reassign ownership
    @markers = @properties.geocoded.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {property: property}),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :description)
  end
end
