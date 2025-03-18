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
    @properties = @collection.properties.order(created_at: :desc) # Load only properties belonging to the collection
    @property = Property.new

    # Build markers for the map
    @markers = @properties.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
        info_window_html: render_to_string(partial: "shared/show/info_window", locals: { property: property })
      }
    end
  end





  private

  def collection_params
    params.require(:collection).permit(:name, :description)
  end
end
